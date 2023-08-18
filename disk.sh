#!/bin/bash

# List available disks
function list_disks(){
  lsblk -o PATH,FSTYPE,SIZE,TYPE,MOUNTPOINT | grep -e "part\|disk" | fzf --header "Select disk: "
}

# Get root and boot partitions
function get_partitions(){
  ROOT_PART=$(list_disks | awk '/part/{print $1}')
  BOOT_PART=$(list_disks | awk '/part/{print $1}')
  
  # Check if valid
  if [ ! -b "$ROOT_PART" ]; then
    echo "Invalid root partition"
    exit 1
  fi

  if [ ! -b "$BOOT_PART" ]; then
    echo "Invalid boot partition"
    exit 1
  fi
}

# Ask about optional partitions
function get_optional_parts(){
  read -p "Separate home partition? (y/N) " do_home
  if [ "$do_home" = "y" ]; then
    HOME_PART=$(list_disks | awk '/part/{print $1}')
  fi

  read -p "Separate swap partition? (y/N) " do_swap
  if [ "$do_swap" = "y" ]; then  
    SWAP_PART=$(list_disks | awk '/part/{print $1}')
  fi
}

# Format, mount, generate fstab
function setup_partitions(){
  # TODO
  echo
}

# Orchestrate partitions
function manage_partitions(){
  get_partitions
  get_optional_parts
  setup_partitions 
}

# Main function
manage_partitions
