# 1º posicionarse donde se ha creado el .sblive
# DEBEMOS TENER INSTALADO mkisofs y xorriso
clear
echo "SCRIPT PARA CONVERTIR FICHEROS .sblive a .iso"
echo "=============================================="
echo "Requisitos: instalado mkisofs y xorriso"
echo "posicionarse en el directorio que contenga el sblive"
echo 
read -p "Pulsa intro para continuar..." nulo
echo "Ficheros .sblive en directorio actual: "
echo "========================================="
find ./ -name *.sblive
read -p "escribe el nombre del fichero .sblive: " sblive
mkdir sblive/
sudo tar -xavf $sblive -C sblive/
sudo chmod 777 -R sblive/
mv sblive/syslinux/syslinux.cfg sblive/syslinux/isolinux.cfg
mv sblive/syslinux/ sblive/isolinux/
xorriso -as mkisofs -V sblive -J -l -b -isohybrid-mbr sblive/isolinux/ -c isolinux/boot.cat -b isolinux/isolinux.bin -iso-level 3 -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot -isohybrid-gpt-basdat -o sblive.iso sblive
isohybrid -h 256 -s 63 --uefi sblive.iso
