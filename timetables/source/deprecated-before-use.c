#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAX_COL 50
#define STR_LEN 500

char splitTypes(char string[], int len){
    int i;
    int flag = 0;
    char find;
    for (i = 0; i < len && !(flag); i++){
        if (string[i] == ','){
            flag = 1;
            find = string[i+1];
            string[i] = '\0';
        }
    }
    return find;
}

int getTypes(char columns[][STR_LEN], int len_col, char types[], char path[]){
    int i;
    int flag;
    int len_buf, len_new;
    char buffer[STR_LEN];
    char type;
    char* eof_test;
    FILE* ptypes = fopen(path, "r");
    if (ptypes == NULL)
        return -1;
    for (i = 0; i < len_col; i++){
        flag = 1;
        rewind(ptypes);
        while (flag) {
            eof_test = fgets(buffer, STR_LEN, ptypes);
            len_buf = strlen(buffer);
            type = splitTypes(buffer, len_buf);
            if (strcmp(buffer, columns[i]) == 0){
                flag = 0;
                types[i] = type;
            }
            if (eof_test == NULL){
                flag = 0;
                types[i] = '!';
            }
        }
    }
    return 0;
}

int getColumns(FILE* file, char columns[][STR_LEN]){
    int i, k = 0, l = 0;
    int len_buf;
    char buffer[STR_LEN];
    rewind(file);
    fgets(buffer, STR_LEN, file);
    len_buf = strlen(buffer);
    for (i = 0; i < len_buf; i++){
        if (buffer[i] == ',' || buffer[i] == '\n') {
            columns[k][l] = '\0';
            k++;
            l = 0;
        }
        else {
            columns[k][l] = buffer[i];
            l++;
        }
    }
    return k;
}

int commaPos(int pos[], char string[], int len){
    int i;
    int j = 0;
    string[0] = 0;
    for (i = 0; i < len; i++){
        if (string[i+1] == ',')
            pos[j++] = i;
    }
    pos[j] = len - 2;
    return j;
}

int writeHeader(FILE* old_file, FILE* new_file, char before_col[], char after_col[]){
    int len;
    char buffer[STR_LEN];
    rewind(old_file);
    fgets(buffer, STR_LEN, old_file);
    len = strlen(buffer);
    buffer[len-1] = '\0';
    strcat(before_col, buffer);
    strcat(before_col, after_col);
    fprintf(new_file, "%s\n", before_col);
    len = strlen(before_col);
    return len;
}

int writeFooter(FILE* end_of_new_file, char command_delimiter){
    fseek(end_of_new_file, -2, SEEK_END);
    fputc(command_delimiter, end_of_new_file);
}

void lineUpdate(char old_string[], int old_str_len, int pos[], int n_col, char types[], char new_string[]){
    int l = 0, k = 0, i;
    for (i = 0; i <= n_col; i++){
        if (types[i] == 's')
            new_string[++k] = '\"';
        if (types[i] == 't')
            new_string[++k] = '\'';

        if (pos[i]+1 == l){ //Empty column handling : add default value and move on.
            new_string[++k] = '0';
        }
        while (l <= pos[i])
            new_string[++k] = old_string[l++];

        if (types[i] == 's')
            new_string[++k] = '\"';
        if (types[i] == 't')
            new_string[++k] = '\'';
        l++;
        if (!(i == n_col))
            new_string[++k] = ',';
    }
    new_string[0] = '(';
    new_string[++k] = ')';
    new_string[++k] = ',';
    new_string[++k] = '\0';
}

int writeFile(FILE* old_file, char head_before[], char head_after[], char types[], char path[]){
    int i;
    int n_col;
    int com_pos[MAX_COL];
    char buffer[STR_LEN];
    char old_string[STR_LEN];
    int buf_len;
    int eof_flag = 0;
    char new_string_buf[STR_LEN]={"Test"};
    char* eof_test;
    FILE* new_file = fopen(path, "w");
    writeHeader(old_file, new_file, head_before, head_after);
    eof_test = fgets(buffer, STR_LEN, old_file);
    while (!(eof_test == NULL)){
        strcpy(old_string, buffer);
        buf_len = strlen(buffer);
        n_col = commaPos(com_pos, buffer, buf_len);
        lineUpdate(old_string, buf_len, com_pos, n_col, types, new_string_buf);
        fprintf(new_file, "%s\n", new_string_buf);
        eof_test = fgets(buffer, STR_LEN, old_file);
    }
    writeFooter(new_file, ';');
    return 0;
}

void main(int argc, char* argv[], char* envp[]){
    int n_col;
    char columns[MAX_COL][STR_LEN];
    char types[MAX_COL];
    char before_col[STR_LEN]={"INSERT INTO table("};
    char after_col[STR_LEN]={") VALUES"};

    FILE* origin_file = fopen(argv[1], "r");
    if (origin_file == NULL) printf("3:");

    n_col = getColumns(origin_file, columns);
    getTypes(columns, n_col, types, argv[3]);
    writeFile(origin_file, before_col, after_col, types, argv[2]);
}
