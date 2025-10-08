#include <stdio.h>
#include <stdlib.h>
#include <fcgi_stdio.h>

#define HTML_FILE "list.html" 

int main() {
    FILE *fp;
    char buffer[1024]; 
    size_t bytesRead;

    while (FCGI_Accept() >= 0) {
       
        printf("Content-Type: text/html\r\n\r\n");

        fp = fopen(HTML_FILE, "r");

        if (fp == NULL) {

            printf("<h1>Error: Could not open %s</h1>", HTML_FILE);
        } else {

            while ((bytesRead = fread(buffer, 1, sizeof(buffer), fp)) > 0) {
                fwrite(buffer, 1, bytesRead, stdout);
            }
            fclose(fp);
        }
        fflush(stdout);
    }
    return 0;
}
