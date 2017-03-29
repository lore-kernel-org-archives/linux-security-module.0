From: lkp@intel.com (kbuild test robot)
Date: Wed, 29 Mar 2017 23:58:24 +0800
Subject: [PATCH net-next v6 11/11] landlock: Add user and kernel
	documentation for Landlock
In-Reply-To: <20170328234650.19695-12-mic@digikod.net>
Message-ID: <201703292327.goXpnbfK%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Micka?l,

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Micka-l-Sala-n/Landlock-LSM-Toward-unprivileged-sandboxing/20170329-211258
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
>> include/uapi/linux/bpf.h:1: warning: no structured comments found
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

vim +1 include/uapi/linux/bpf.h

daedfb22 Alexei Starovoitov 2014-09-04 @1  /* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
daedfb22 Alexei Starovoitov 2014-09-04  2   *
daedfb22 Alexei Starovoitov 2014-09-04  3   * This program is free software; you can redistribute it and/or
daedfb22 Alexei Starovoitov 2014-09-04  4   * modify it under the terms of version 2 of the GNU General Public
daedfb22 Alexei Starovoitov 2014-09-04  5   * License as published by the Free Software Foundation.
daedfb22 Alexei Starovoitov 2014-09-04  6   */
daedfb22 Alexei Starovoitov 2014-09-04  7  #ifndef _UAPI__LINUX_BPF_H__
daedfb22 Alexei Starovoitov 2014-09-04  8  #define _UAPI__LINUX_BPF_H__
daedfb22 Alexei Starovoitov 2014-09-04  9  

:::::: The code at line 1 was first introduced by commit
:::::: daedfb22451dd02b35c0549566cbb7cc06bdd53b net: filter: split filter.h and expose eBPF to user space

:::::: TO: Alexei Starovoitov <ast@plumgrid.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6576 bytes
Desc: not available
URL: <http://kernsec.org/pipermail/linux-security-module-archive/attachments/20170329/c04590ac/attachment.bin>
