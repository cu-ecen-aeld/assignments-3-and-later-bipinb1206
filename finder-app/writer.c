#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <syslog.h>

int main(int argc, char *argv[]) {
    // Check if the required arguments are specified
    if (argc != 3) {
        fprintf(stderr, "Usage: writer <writefile> <writestr>\n");
        return 1;
    }

    // Get the path to the writefile file
    char *writefile = argv[1];

    // Get the write string
    char *writestr = argv[2];

    // Create the writefile file, overwriting any existing file
    FILE *file = fopen(writefile, "w");
    if (file == NULL) {
        fprintf(stderr, "Error: Could not create file %s\n", writefile);
        openlog("writer", LOG_CONS | LOG_PID, LOG_USER);
        syslog(LOG_ERR, "Error creating file %s: %m", writefile);
        closelog();
	return 1;
    }
    fprintf(file, "%s", writestr);
    fclose(file);

    // Log the write action
    openlog("writer", LOG_CONS | LOG_PID, LOG_USER);
    syslog(LOG_DEBUG, "Writing \"%s\" to \"%s\"", writestr, writefile);
    closelog();

    // Check if the file was created successfully
    if (access(writefile, F_OK) == -1) {
        openlog("writer", LOG_CONS | LOG_PID, LOG_USER);
        syslog(LOG_ERR, "Error checking file existence for %s: %m", writefile);
        closelog();
        fprintf(stderr, "Error: Could not create file %s\n", writefile);
	return 1;
    }

    // Success!
    return 0;
}

