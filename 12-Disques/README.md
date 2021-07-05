# Disques

## Partitionner

```shell
sudo mkfs -t ext4 /dev/sda1
```

## Vérifier

```shell
sudo tune2fs -l /dev/sda1
df -hi /dev/sda1
```

## Montage/démontage USB

```shell
sudo apt install udisks2
```

```shell
lsblk

ls /dev/sda*
```

Les disques ont un nom de la forme `sdXY` avec `X` une lettre et `Y` un numéro.

## Répertoire de montage usuel

```
/media/<user>/
```

## Montage

* Méthode n°1 :

```shell
udisksctl mount -b <disk>
```

* Méthode n°2 :

```shell
mount [-t ext4|fat|...] /dev/sda1 /mnt/<dir>
```

## Démontage

* Méthode n°1 :

```shell
udisksctl unmount -b /dev/<disk>
```

* Méthode n°2 :

```shell
umount /mnt/<dir>
```
