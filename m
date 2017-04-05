From: dhowells@redhat.com (David Howells)
Date: Wed, 05 Apr 2017 17:56:53 +0100
Subject: [PATCH 00/38] Annotate hw config module params for future lockdown
Message-ID: <149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


Here's a set of patches that annotate module parameters that configure
hardware resources including ioports, iomem addresses, irq lines and dma
channels.

This will be used in a future patch[*] to prohibit the use of such module
parameters so that hardware can't be abused to gain access to the running
kernel image.

 [*] Which is in my "Kernel lockdown" series, posted separately for length
     reasons.

This is done by changing:

	module_param(n, t, p)
	module_param_named(n, v, t, p)
	module_param_array(n, t, m, p)

to:

	module_param_hw(n, t, hwtype, p)
	module_param_hw_named(n, v, t, hwtype, p)
	module_param_hw_array(n, t, hwtype, m, p)

where hwtype specifies the type of the resource being configured.

Note that the hwtype is compile checked, but not currently stored (the
lockdown code probably won't require it).  It is, however, there for future
use.

Further note that the hwtype can also be used for grepping.

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=hwparam

at tag:

	hwparam-20170405

David
---
David Howells (38):
      Annotate module params that specify hardware parameters (eg. ioport)
      Annotate hardware config module parameters in arch/x86/mm/
      Annotate hardware config module parameters in drivers/char/ipmi/
      Annotate hardware config module parameters in drivers/char/mwave/
      Annotate hardware config module parameters in drivers/char/
      Annotate hardware config module parameters in drivers/clocksource/
      Annotate hardware config module parameters in drivers/cpufreq/
      Annotate hardware config module parameters in drivers/gpio/
      Annotate hardware config module parameters in drivers/i2c/
      Annotate hardware config module parameters in drivers/iio/
      Annotate hardware config module parameters in drivers/input/
      Annotate hardware config module parameters in drivers/isdn/
      Annotate hardware config module parameters in drivers/media/
      Annotate hardware config module parameters in drivers/misc/
      Annotate hardware config module parameters in drivers/mmc/host/
      Annotate hardware config module parameters in drivers/net/appletalk/
      Annotate hardware config module parameters in drivers/net/arcnet/
      Annotate hardware config module parameters in drivers/net/can/
      Annotate hardware config module parameters in drivers/net/ethernet/
      Annotate hardware config module parameters in drivers/net/hamradio/
      Annotate hardware config module parameters in drivers/net/irda/
      Annotate hardware config module parameters in drivers/net/wan/
      Annotate hardware config module parameters in drivers/net/wireless/
      Annotate hardware config module parameters in drivers/parport/
      Annotate hardware config module parameters in drivers/pci/hotplug/
      Annotate hardware config module parameters in drivers/pcmcia/
      Annotate hardware config module parameters in drivers/scsi/
      Annotate hardware config module parameters in drivers/staging/media/
      Annotate hardware config module parameters in drivers/staging/speakup/
      Annotate hardware config module parameters in drivers/staging/vme/
      Annotate hardware config module parameters in drivers/tty/
      Annotate hardware config module parameters in drivers/video/
      Annotate hardware config module parameters in drivers/watchdog/
      Annotate hardware config module parameters in fs/pstore/
      Annotate hardware config module parameters in sound/drivers/
      Annotate hardware config module parameters in sound/isa/
      Annotate hardware config module parameters in sound/oss/
      Annotate hardware config module parameters in sound/pci/


 arch/x86/mm/testmmiotrace.c                 |    2 -
 drivers/char/applicom.c                     |    4 +-
 drivers/char/ipmi/ipmi_si_intf.c            |   14 +++---
 drivers/char/mwave/mwavedd.c                |    8 ++-
 drivers/clocksource/cs5535-clockevt.c       |    2 -
 drivers/cpufreq/speedstep-smi.c             |    2 -
 drivers/gpio/gpio-104-dio-48e.c             |    4 +-
 drivers/gpio/gpio-104-idi-48.c              |    4 +-
 drivers/gpio/gpio-104-idio-16.c             |    4 +-
 drivers/gpio/gpio-gpio-mm.c                 |    2 -
 drivers/gpio/gpio-ws16c48.c                 |    4 +-
 drivers/i2c/busses/i2c-ali15x3.c            |    2 -
 drivers/i2c/busses/i2c-elektor.c            |    6 +-
 drivers/i2c/busses/i2c-parport-light.c      |    4 +-
 drivers/i2c/busses/i2c-pca-isa.c            |    4 +-
 drivers/i2c/busses/i2c-piix4.c              |    2 -
 drivers/i2c/busses/i2c-sis5595.c            |    2 -
 drivers/i2c/busses/i2c-viapro.c             |    2 -
 drivers/i2c/busses/scx200_acb.c             |    2 -
 drivers/iio/adc/stx104.c                    |    2 -
 drivers/iio/dac/cio-dac.c                   |    2 -
 drivers/input/mouse/inport.c                |    2 -
 drivers/input/mouse/logibm.c                |    2 -
 drivers/input/touchscreen/mk712.c           |    4 +-
 drivers/isdn/hardware/avm/b1isa.c           |    4 +-
 drivers/isdn/hardware/avm/t1isa.c           |    4 +-
 drivers/isdn/hisax/config.c                 |   10 ++--
 drivers/media/pci/zoran/zoran_card.c        |    2 -
 drivers/media/rc/serial_ir.c                |   10 ++--
 drivers/misc/dummy-irq.c                    |    2 -
 drivers/mmc/host/wbsd.c                     |    8 ++-
 drivers/net/appletalk/cops.c                |    6 +-
 drivers/net/appletalk/ltpc.c                |    6 +-
 drivers/net/arcnet/com20020-isa.c           |    4 +-
 drivers/net/arcnet/com90io.c                |    4 +-
 drivers/net/arcnet/com90xx.c                |    4 +-
 drivers/net/can/cc770/cc770_isa.c           |    8 ++-
 drivers/net/can/sja1000/sja1000_isa.c       |    8 ++-
 drivers/net/ethernet/3com/3c509.c           |    2 -
 drivers/net/ethernet/3com/3c59x.c           |    4 +-
 drivers/net/ethernet/8390/ne.c              |    4 +-
 drivers/net/ethernet/8390/smc-ultra.c       |    4 +-
 drivers/net/ethernet/8390/wd.c              |    8 ++-
 drivers/net/ethernet/amd/lance.c            |    6 +-
 drivers/net/ethernet/amd/ni65.c             |    6 +-
 drivers/net/ethernet/cirrus/cs89x0.c        |    6 +-
 drivers/net/ethernet/dec/tulip/de4x5.c      |    2 -
 drivers/net/ethernet/hp/hp100.c             |    2 -
 drivers/net/ethernet/realtek/atp.c          |    4 +-
 drivers/net/ethernet/smsc/smc9194.c         |    4 +-
 drivers/net/hamradio/baycom_epp.c           |    2 -
 drivers/net/hamradio/baycom_par.c           |    2 -
 drivers/net/hamradio/baycom_ser_fdx.c       |    4 +-
 drivers/net/hamradio/baycom_ser_hdx.c       |    4 +-
 drivers/net/hamradio/dmascc.c               |    2 -
 drivers/net/irda/ali-ircc.c                 |    6 +-
 drivers/net/irda/nsc-ircc.c                 |    6 +-
 drivers/net/irda/smsc-ircc2.c               |   10 ++--
 drivers/net/irda/w83977af_ir.c              |    4 +-
 drivers/net/wan/cosa.c                      |    6 +-
 drivers/net/wan/hostess_sv11.c              |    6 +-
 drivers/net/wan/sbni.c                      |    4 +-
 drivers/net/wan/sealevel.c                  |    8 ++-
 drivers/net/wireless/cisco/airo.c           |    4 +-
 drivers/parport/parport_pc.c                |    8 ++-
 drivers/pci/hotplug/cpcihp_generic.c        |    2 -
 drivers/pcmcia/i82365.c                     |    8 ++-
 drivers/pcmcia/tcic.c                       |    8 ++-
 drivers/scsi/aha152x.c                      |    4 +-
 drivers/scsi/aha1542.c                      |    2 -
 drivers/scsi/g_NCR5380.c                    |    8 ++-
 drivers/scsi/gdth.c                         |    2 -
 drivers/scsi/qlogicfas.c                    |    4 +-
 drivers/staging/media/lirc/lirc_sir.c       |    4 +-
 drivers/staging/speakup/speakup_acntpc.c    |    2 -
 drivers/staging/speakup/speakup_dtlk.c      |    2 -
 drivers/staging/speakup/speakup_keypc.c     |    2 -
 drivers/staging/vme/devices/vme_pio2_core.c |    8 ++-
 drivers/tty/cyclades.c                      |    4 +-
 drivers/tty/moxa.c                          |    2 -
 drivers/tty/mxser.c                         |    2 -
 drivers/tty/rocket.c                        |   10 ++--
 drivers/tty/serial/8250/8250_core.c         |    4 +-
 drivers/tty/synclink.c                      |    6 +-
 drivers/video/fbdev/arcfb.c                 |    8 ++-
 drivers/video/fbdev/n411.c                  |    6 +-
 drivers/watchdog/cpu5wdt.c                  |    2 -
 drivers/watchdog/eurotechwdt.c              |    4 +-
 drivers/watchdog/pc87413_wdt.c              |    2 -
 drivers/watchdog/sc1200wdt.c                |    2 -
 drivers/watchdog/wdt.c                      |    4 +-
 fs/pstore/ram.c                             |    2 -
 include/linux/moduleparam.h                 |   65 +++++++++++++++++++++++++++
 sound/drivers/mpu401/mpu401.c               |    4 +-
 sound/drivers/mtpav.c                       |    4 +-
 sound/drivers/serial-u16550.c               |    4 +-
 sound/isa/ad1848/ad1848.c                   |    6 +-
 sound/isa/adlib.c                           |    2 -
 sound/isa/cmi8328.c                         |   12 ++---
 sound/isa/cmi8330.c                         |   20 ++++----
 sound/isa/cs423x/cs4231.c                   |   12 ++---
 sound/isa/cs423x/cs4236.c                   |   18 ++++---
 sound/isa/es1688/es1688.c                   |   12 ++---
 sound/isa/es18xx.c                          |   12 ++---
 sound/isa/galaxy/galaxy.c                   |   16 +++----
 sound/isa/gus/gusclassic.c                  |    8 ++-
 sound/isa/gus/gusextreme.c                  |   16 +++----
 sound/isa/gus/gusmax.c                      |    8 ++-
 sound/isa/gus/interwave.c                   |   10 ++--
 sound/isa/msnd/msnd_pinnacle.c              |   20 ++++----
 sound/isa/opl3sa2.c                         |   16 +++----
 sound/isa/opti9xx/miro.c                    |   14 +++---
 sound/isa/opti9xx/opti92x-ad1848.c          |   14 +++---
 sound/isa/sb/jazz16.c                       |   12 ++---
 sound/isa/sb/sb16.c                         |   14 +++---
 sound/isa/sb/sb8.c                          |    6 +-
 sound/isa/sc6000.c                          |   12 ++---
 sound/isa/sscape.c                          |   12 ++---
 sound/isa/wavefront/wavefront.c             |   18 ++++---
 sound/oss/ad1848.c                          |    8 ++-
 sound/oss/aedsp16.c                         |   12 ++---
 sound/oss/mpu401.c                          |    4 +-
 sound/oss/msnd_pinnacle.c                   |   20 ++++----
 sound/oss/opl3.c                            |    2 -
 sound/oss/pas2_card.c                       |   18 ++++---
 sound/oss/pss.c                             |   14 +++---
 sound/oss/sb_card.c                         |   10 ++--
 sound/oss/trix.c                            |   18 ++++---
 sound/oss/uart401.c                         |    4 +-
 sound/oss/uart6850.c                        |    4 +-
 sound/oss/waveartist.c                      |    8 ++-
 sound/pci/als4000.c                         |    2 -
 sound/pci/cmipci.c                          |    6 +-
 sound/pci/ens1370.c                         |    2 -
 sound/pci/riptide/riptide.c                 |    6 +-
 sound/pci/sonicvibes.c                      |    2 -
 sound/pci/via82xx.c                         |    2 -
 sound/pci/ymfpci/ymfpci.c                   |    6 +-
 138 files changed, 493 insertions(+), 430 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
