/*
 * music.c
 *
 *  Created on: Apr 24, 2023
 *      Author: conno
 */
#include "open_interface.h"
#include "music.h"

void play_song(int choice)
{
    if (choice == 1)
    {
        unsigned char smokeOnTheWaterNoteCount = 12;
        unsigned char smokeOnTheWaterNotes[12] = { 38, 41, 43, 38, 41, 44, 43, 38, 41, 43, 41, 38 };
        unsigned char smokeOnTheWaterNoteDurations[12] = { 38, 38, 58, 38, 38, 19, 77, 38, 38, 58, 38, 77 };
        oi_loadSong(1, smokeOnTheWaterNoteCount, smokeOnTheWaterNotes, smokeOnTheWaterNoteDurations);
        oi_play_song(1);
    }

    if (choice == 2)
    {
        unsigned char smokeOnTheWaterNoteCount = 12;
        unsigned char smokeOnTheWaterNotes[12] = { 50, 53, 55, 50, 53, 56, 55, 50, 53, 55, 53, 50 };
        unsigned char smokeOnTheWaterNoteDurations[12] = { 38, 38, 58, 38, 38, 19, 77, 38, 38, 58, 38, 77 };
        oi_loadSong(2, smokeOnTheWaterNoteCount, smokeOnTheWaterNotes, smokeOnTheWaterNoteDurations);
        oi_play_song(2);
    }
}
