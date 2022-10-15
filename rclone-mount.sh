#!/bin/bash
if [[ -z "${RCLONE_MOUNT_PARAMS}" ]]; then
  echo "Running rclone with default params..."
  /usr/bin/rclone --config=/rclone/config/rclone.conf --cache-dir=/rclone/cache mount remote: /mnt/remote --vfs-cache-mode writes --allow-other --allow-non-empty
else
    echo "Running rclone with custom params from env variable RCLONE_MOUNT_PARAMS: ${RCLONE_MOUNT_PARAMS}"
  /usr/bin/rclone --config=/rclone/config/rclone.conf --cache-dir=/rclone/cache mount remote: /mnt/remote ${RCLONE_MOUNT_PARAMS}
fi
