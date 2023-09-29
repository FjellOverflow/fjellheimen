#!/usr/bin/env bash

NOTIFY=http://util-ntfy:80/media

CONTENT=X

case "$sonarr_eventtype" in
  "Grab")
    TITLE="Episode Grabbed"

    CONTENT="$sonarr_series_title"
    CONTENT="$CONTENT, Season $sonarr_release_seasonnumber"
    CONTENT="$CONTENT, Episode $sonarr_release_episodenumbers"
    CONTENT="$CONTENT - $sonarr_release_episodetitles"
    CONTENT="$CONTENT [$sonarr_release_quality]"
    ;;
  "Download")
    TITLE="Episode Downloaded"

    CONTENT="$sonarr_series_title"
    CONTENT="$CONTENT, Season $sonarr_episodefile_seasonnumber"
    CONTENT="$CONTENT, Episode $sonarr_episodefile_episodenumbers"
    CONTENT="$CONTENT - $sonarr_episodefile_episodetitles"
    CONTENT="$CONTENT [$sonarr_episodefile_quality]"
    ;;
  "EpisodeFileDelete")
    TITLE="Episode File Deleted"

    CONTENT="$sonarr_series_title"
    CONTENT="$CONTENT, Season $sonarr_episodefile_seasonnumber"
    CONTENT="$CONTENT, Episode $sonarr_episodefile_episodenumbers"
    CONTENT="$CONTENT - $sonarr_episodefile_episodetitles"
    CONTENT="$CONTENT [$sonarr_episodefile_quality]"
    ;;
  "SeriesDelete")
    TITLE="Series Deleted"

    CONTENT="$sonarr_series_title"
    ;;
  "ApplicationUpdate")
    TITLE="$sonarr_update_message"

    CONTENT="Updated from $sonarr_update_previousversion to $sonarr_update_newversion"
    ;;
  "Test")
    TITLE="Test Notification"
    CONTENT="This is a test message from Sonarr"
    ;;
  *)
    TITLE="$sonarr_eventtype"
    CONTENT="Unknown event type"
    ;;
esac

curl -H "Title: Sonarr - $TITLE" -d "$CONTENT" "$NOTIFY"
