From: lkp@intel.com (kbuild test robot)
Date: Sat, 29 Apr 2017 15:02:23 +0800
Subject: [PATCH v2 3/3] tpm: vtpm_proxy: Add ioctl to request locality
	prepended to command
In-Reply-To: <1493384538-27883-4-git-send-email-stefanb@linux.vnet.ibm.com>
Message-ID: <201704291410.uERkSu2V%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Stefan,

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on v4.11-rc8 next-20170428]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stefan-Berger/Extend-the-vTPM-proxy-driver-to-pass-locality-to-emulator/20170429-115352
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   include/linux/init.h:1: warning: no structured comments found
   kernel/sched/core.c:2085: warning: No description found for parameter 'rf'
   kernel/sched/core.c:2085: warning: Excess function parameter 'cookie' description in 'try_to_wake_up_local'
   include/linux/kthread.h:26: warning: Excess function parameter '...' description in 'kthread_create'
   kernel/sys.c:1: warning: no structured comments found
   include/linux/device.h:969: warning: No description found for parameter 'dma_ops'
   drivers/dma-buf/seqno-fence.c:1: warning: no structured comments found
   include/linux/iio/iio.h:597: warning: No description found for parameter 'trig_readonly'
   include/linux/iio/trigger.h:151: warning: No description found for parameter 'indio_dev'
   include/linux/iio/trigger.h:151: warning: No description found for parameter 'trig'
   include/linux/device.h:970: warning: No description found for parameter 'dma_ops'
   drivers/regulator/core.c:1467: warning: Excess function parameter 'ret' description in 'regulator_dev_lookup'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'open'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'preclose'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'postclose'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'lastclose'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'set_busid'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'irq_handler'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'irq_preinstall'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'irq_postinstall'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'irq_uninstall'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'debugfs_init'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'debugfs_cleanup'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'gem_open_object'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'gem_close_object'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'prime_handle_to_fd'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'prime_fd_to_handle'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'gem_prime_export'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'gem_prime_import'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'gem_prime_pin'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'gem_prime_unpin'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'gem_prime_res_obj'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'gem_prime_get_sg_table'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'gem_prime_import_sg_table'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'gem_prime_vmap'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'gem_prime_vunmap'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'gem_prime_mmap'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'gem_vm_ops'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'major'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'minor'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'patchlevel'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'name'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'desc'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'date'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'driver_features'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'ioctls'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'num_ioctls'
   include/drm/drm_drv.h:438: warning: No description found for parameter 'fops'
   include/drm/drm_color_mgmt.h:1: warning: no structured comments found
   drivers/gpu/drm/drm_fb_cma_helper.c:557: warning: Excess function parameter 'num_crtc' description in 'drm_fbdev_cma_init'
   drivers/gpu/drm/drm_fb_cma_helper.c:558: warning: Excess function parameter 'num_crtc' description in 'drm_fbdev_cma_init'
   drivers/gpu/drm/i915/intel_lpe_audio.c:342: warning: No description found for parameter 'pipe'
   drivers/gpu/drm/i915/intel_lpe_audio.c:342: warning: No description found for parameter 'dp_output'
   drivers/gpu/drm/i915/intel_lpe_audio.c:342: warning: No description found for parameter 'link_rate'
   drivers/gpu/drm/i915/intel_lpe_audio.c:343: warning: No description found for parameter 'pipe'
   drivers/gpu/drm/i915/intel_lpe_audio.c:343: warning: No description found for parameter 'dp_output'
   drivers/gpu/drm/i915/intel_lpe_audio.c:343: warning: No description found for parameter 'link_rate'
   drivers/media/dvb-core/dvb_frontend.h:677: warning: No description found for parameter 'refcount'
>> include/uapi/linux/vtpm_proxy.h:30: warning: Enum value 'VTPM_PROXY_FLAG_PREPEND_LOCALITY' not described in enum 'vtpm_proxy_flags'
   Documentation/core-api/assoc_array.rst:13: WARNING: Enumerated list ends without a blank line; unexpected unindent.
   Documentation/doc-guide/sphinx.rst:110: ERROR: Unknown target name: "sphinx c domain".
   kernel/sched/fair.c:7616: WARNING: Inline emphasis start-string without end-string.
   kernel/time/timer.c:1200: ERROR: Unexpected indentation.
   kernel/time/timer.c:1202: ERROR: Unexpected indentation.
   kernel/time/timer.c:1203: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:122: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:125: ERROR: Unexpected indentation.
   include/linux/wait.h:127: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/time/hrtimer.c:990: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/signal.c:322: WARNING: Inline literal start-string without end-string.
   include/linux/iio/iio.h:219: ERROR: Unexpected indentation.
   include/linux/iio/iio.h:220: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/iio/iio.h:226: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/iio/industrialio-core.c:639: ERROR: Unknown target name: "iio_val".
   drivers/iio/industrialio-core.c:646: ERROR: Unknown target name: "iio_val".
   drivers/message/fusion/mptbase.c:5051: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/tty/serial/serial_core.c:1898: WARNING: Definition list ends without a blank line; unexpected unindent.
   include/linux/regulator/driver.h:271: ERROR: Unknown target name: "regulator_regmap_x_voltage".
   include/linux/spi/spi.h:369: ERROR: Unexpected indentation.
   drivers/usb/core/message.c:478: ERROR: Unexpected indentation.
   drivers/usb/core/message.c:479: WARNING: Block quote ends without a blank line; unexpected unindent.
   Documentation/driver-api/usb.rst:623: ERROR: Unknown target name: "usb_type".
   Documentation/driver-api/usb.rst:623: ERROR: Unknown target name: "usb_dir".
   Documentation/driver-api/usb.rst:623: ERROR: Unknown target name: "usb_recip".
   Documentation/driver-api/usb.rst:689: ERROR: Unknown target name: "usbdevfs_urb_type".
   sound/soc/soc-core.c:2670: ERROR: Unknown target name: "snd_soc_daifmt".
   sound/core/jack.c:312: ERROR: Unknown target name: "snd_jack_btn".
   WARNING: dvipng command 'dvipng' cannot be run (needed for math display), check the imgmath_dvipng setting

vim +30 include/uapi/linux/vtpm_proxy.h

6f99612e Stefan Berger   2016-04-18  14   */
6f99612e Stefan Berger   2016-04-18  15  
6f99612e Stefan Berger   2016-04-18  16  #ifndef _UAPI_LINUX_VTPM_PROXY_H
6f99612e Stefan Berger   2016-04-18  17  #define _UAPI_LINUX_VTPM_PROXY_H
6f99612e Stefan Berger   2016-04-18  18  
6f99612e Stefan Berger   2016-04-18  19  #include <linux/types.h>
6f99612e Stefan Berger   2016-04-18  20  #include <linux/ioctl.h>
6f99612e Stefan Berger   2016-04-18  21  
7ea7861c Jarkko Sakkinen 2016-11-03  22  /**
7ea7861c Jarkko Sakkinen 2016-11-03  23   * enum vtpm_proxy_flags - flags for the proxy TPM
7ea7861c Jarkko Sakkinen 2016-11-03  24   * @VTPM_PROXY_FLAG_TPM2:	the proxy TPM uses TPM 2.0 protocol
222e0c7c Stefan Berger   2017-04-28  25   * @VTPM_PROXY_PREPEND_LOCALITY:locality byte prepended on each command
7ea7861c Jarkko Sakkinen 2016-11-03  26   */
7ea7861c Jarkko Sakkinen 2016-11-03  27  enum vtpm_proxy_flags {
7ea7861c Jarkko Sakkinen 2016-11-03  28  	VTPM_PROXY_FLAG_TPM2			= 1,
222e0c7c Stefan Berger   2017-04-28  29  	VTPM_PROXY_FLAG_PREPEND_LOCALITY	= 2,
7ea7861c Jarkko Sakkinen 2016-11-03 @30  };
6f99612e Stefan Berger   2016-04-18  31  
7ea7861c Jarkko Sakkinen 2016-11-03  32  /**
7ea7861c Jarkko Sakkinen 2016-11-03  33   * struct vtpm_proxy_new_dev - parameter structure for the
7ea7861c Jarkko Sakkinen 2016-11-03  34   *                             %VTPM_PROXY_IOC_NEW_DEV ioctl
7ea7861c Jarkko Sakkinen 2016-11-03  35   * @flags:	flags for the proxy TPM
7ea7861c Jarkko Sakkinen 2016-11-03  36   * @tpm_num:	index of the TPM device
7ea7861c Jarkko Sakkinen 2016-11-03  37   * @fd:		the file descriptor used by the proxy TPM
7ea7861c Jarkko Sakkinen 2016-11-03  38   * @major:	the major number of the TPM device

:::::: The code at line 30 was first introduced by commit
:::::: 7ea7861c8c2462af932410c54542cb279683eaf8 tpm, tpm_vtpm_proxy: add kdoc comments for VTPM_PROXY_IOC_NEW_DEV

:::::: TO: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
:::::: CC: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6576 bytes
Desc: not available
URL: <http://kernsec.org/pipermail/linux-security-module-archive/attachments/20170429/a16fb484/attachment.bin>
