#include <string.h>
#include <stdio.h>
#include <stdlib.h>
//gcc -o {exename} {c filename}

int wordCount(char *s);

int main(){
    char input[] = "We hold these truths to be self-evident, that all men are created equal, that they are endowed, by their Creator, with certain unalienable Rights, that among these are Life, Liberty, and the pursuit of Happiness. That to secure these rights, Governments are instituted among Men, deriving their just powers from the consent of the governed, That whenever any Form of Government becomes destructive of these ends, it is the Right of the People to alter or abolish it, and to institute new Government, laying its foundation on such principles, and organizing its powers in such form, as to them shall seem most likely to effect their Safety and Happiness. Prudence, indeed, will dictate that Governments long established should not be changed for light and transient causes; and accordingly all experience hath shewn, that mankind are more disposed to suffer, while evils are sufferable, than to right themselves by abolishing the forms to which they are accustomed. But when a long train of abuses and usurpations, pursuing invariably the same Object, evinces a design to reduce them under absolute Despotism, it is their right, it is their duty, to throw off such Government, and to provide new Guards for their future security.";

    int sentences = 0;
    int words = 0;
    const int max = strlen(input);
    char* p;
    char *pointers[max];

    int i=0;
    p = strtok(input, ".?!");
    while(p != NULL){
        sentences++;
        
        pointers[i] = malloc(sizeof(p));
        pointers[i] = p;
        p = strtok(NULL, ".?!");
        i++;
    }
    for (int x=0; x<sentences; x++){
        words += wordCount(pointers[x]);
    }

    

    printf("sentences: %d\n", sentences);
    printf("words: %d\n", words);

    printf("The average words per sentence is: %d\n", words/sentences);
    return 0;
}

int wordCount(char *s){ 
    int size;
    char * token;
    char * copy;

    size = strlen(s);
    copy = (char*) malloc(size);

    memcpy(copy, s, size);
    int count = 0;
    token = strtok(copy, " ");
    while (token != NULL){
        token = strtok(NULL, " ");
        count++;
    }
    return count;
}
