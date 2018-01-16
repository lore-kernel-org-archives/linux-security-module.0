From: dongsu@kinvolk.io (Dongsu Park)
Date: Tue, 16 Jan 2018 11:47:26 +0100
Subject: [PATCH 2/2] ima: turn on force option for FUSE in builtin policies
In-Reply-To: <201801150202.kLQoVeav%fengguang.wu@intel.com>
References: <7a89ce9a7b8264f83fa5d61e146c01571017cca0.1515682581.git.dongsu@kinvolk.io>
	<201801150202.kLQoVeav%fengguang.wu@intel.com>
Message-ID: <CANxcAMv6itthEKL4ph+icPLbYc2O8mffcS-phg-2+Jqe--mttA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

On Sun, Jan 14, 2018 at 8:09 PM, kbuild test robot <lkp@intel.com> wrote:
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.15-rc7 next-20180112]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

As already mentioned in the commit message, this patch depends on
patches that are not yet in the mainline, or not even in next-integrity.
So please make it excluded from kbuild.

Thanks,
Dongsu

> url:    https://github.com/0day-ci/linux/commits/Dongsu-Park/turn-on-force-option-for-FUSE-in-builtin-policies/20180115-015830
> config: xtensa-allmodconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=xtensa
>
> All errors (new ones prefixed by >>):
>
>>> security/integrity/ima/ima_policy.c:130:74: error: 'IMA_FORCE' undeclared here (not in a function); did you mean 'IMA_FUNC'?
>      {.action = MEASURE, .fsmagic = FUSE_SUPER_MAGIC, .flags = IMA_FSMAGIC | IMA_FORCE},
>                                                                              ^~~~~~~~~
>                                                                              IMA_FUNC
>    security/integrity/ima/ima_policy.c:158:73: error: invalid operands to binary | (have 'int' and 'struct ima_rule_entry *')
>      {.action = APPRAISE, .fsmagic = FUSE_SUPER_MAGIC, .flags = IMA_FSMAGIC | IMA_FORCE},
>                                                                             ^
>    security/integrity/ima/ima_policy.c:29:21: warning: initialization makes integer from pointer without a cast [-Wint-conversion]
>     #define IMA_FSMAGIC 0x0004
>                         ^
>    security/integrity/ima/ima_policy.c:158:61: note: in expansion of macro 'IMA_FSMAGIC'
>      {.action = APPRAISE, .fsmagic = FUSE_SUPER_MAGIC, .flags = IMA_FSMAGIC | IMA_FORCE},
>                                                                 ^~~~~~~~~~~
>    security/integrity/ima/ima_policy.c:29:21: note: (near initialization for 'default_appraise_rules[14].flags')
>     #define IMA_FSMAGIC 0x0004
>                         ^
>    security/integrity/ima/ima_policy.c:158:61: note: in expansion of macro 'IMA_FSMAGIC'
>      {.action = APPRAISE, .fsmagic = FUSE_SUPER_MAGIC, .flags = IMA_FSMAGIC | IMA_FORCE},
>                                                                 ^~~~~~~~~~~
>    security/integrity/ima/ima_policy.c:29:21: error: initializer element is not constant
>     #define IMA_FSMAGIC 0x0004
>                         ^
>    security/integrity/ima/ima_policy.c:158:61: note: in expansion of macro 'IMA_FSMAGIC'
>      {.action = APPRAISE, .fsmagic = FUSE_SUPER_MAGIC, .flags = IMA_FSMAGIC | IMA_FORCE},
>                                                                 ^~~~~~~~~~~
>    security/integrity/ima/ima_policy.c:29:21: note: (near initialization for 'default_appraise_rules[14].flags')
>     #define IMA_FSMAGIC 0x0004
>                         ^
>    security/integrity/ima/ima_policy.c:158:61: note: in expansion of macro 'IMA_FSMAGIC'
>      {.action = APPRAISE, .fsmagic = FUSE_SUPER_MAGIC, .flags = IMA_FSMAGIC | IMA_FORCE},
>                                                                 ^~~~~~~~~~~
>
> vim +130 security/integrity/ima/ima_policy.c
>
>    115
>    116  static struct ima_rule_entry default_measurement_rules[] __ro_after_init = {
>    117          {.action = MEASURE, .func = MMAP_CHECK, .mask = MAY_EXEC,
>    118           .flags = IMA_FUNC | IMA_MASK},
>    119          {.action = MEASURE, .func = BPRM_CHECK, .mask = MAY_EXEC,
>    120           .flags = IMA_FUNC | IMA_MASK},
>    121          {.action = MEASURE, .func = FILE_CHECK, .mask = MAY_READ,
>    122           .uid = GLOBAL_ROOT_UID, .uid_op = &uid_eq,
>    123           .flags = IMA_FUNC | IMA_INMASK | IMA_EUID},
>    124          {.action = MEASURE, .func = FILE_CHECK, .mask = MAY_READ,
>    125           .uid = GLOBAL_ROOT_UID, .uid_op = &uid_eq,
>    126           .flags = IMA_FUNC | IMA_INMASK | IMA_UID},
>    127          {.action = MEASURE, .func = MODULE_CHECK, .flags = IMA_FUNC},
>    128          {.action = MEASURE, .func = FIRMWARE_CHECK, .flags = IMA_FUNC},
>    129          {.action = MEASURE, .func = POLICY_CHECK, .flags = IMA_FUNC},
>  > 130          {.action = MEASURE, .fsmagic = FUSE_SUPER_MAGIC, .flags = IMA_FSMAGIC | IMA_FORCE},
>    131  };
>    132
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
