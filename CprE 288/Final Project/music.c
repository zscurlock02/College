/*
 * music.c
 *
 *  Created on: Apr 24, 2023
 *      Author: Connor Hand
 */
#include "open_interface.h"
#include "music.h"

void play_song(int choice)
{
    //Second part of Fortnite default dance.
    if (choice == 1)
    {
        unsigned char fortniteNoteCount2 = 5;
        unsigned char fortniteNotes2[5] = {60, 58, 55, 53, 55};
        unsigned char fortniteNoteDurations2[5] = {12, 12, 12, 12, 12};
        oi_loadSong(1, fortniteNoteCount2, fortniteNotes2, fortniteNoteDurations2);
        oi_play_song(1);
    }

    //Smoke On The Water
    if (choice == 2)
    {
        unsigned char smokeOnTheWaterNoteCount = 12;
        unsigned char smokeOnTheWaterNotes[12] = { 50, 53, 55, 50, 53, 56, 55, 50, 53, 55, 53, 50 };
        unsigned char smokeOnTheWaterNoteDurations[12] = { 38, 38, 58, 38, 38, 19, 77, 38, 38, 58, 38, 77 };
        oi_loadSong(2, smokeOnTheWaterNoteCount, smokeOnTheWaterNotes, smokeOnTheWaterNoteDurations);
        oi_play_song(2);
    }

    //First part of Fortnite default dance.
    if (choice == 3) {
        unsigned char fortniteNoteCount = 14;
        unsigned char fortniteNotes[14] = {55, 58, 60, 60, 58, 31 ,55, 58, 60, 60, 58, 55, 53, 55};
        unsigned char fortniteNoteDurations[14] = {12, 12, 12, 36, 24, 96, 12, 12, 12, 24, 24, 24, 12, 24};
        oi_loadSong(3, fortniteNoteCount, fortniteNotes, fortniteNoteDurations);
        oi_play_song(3);
    }


}
