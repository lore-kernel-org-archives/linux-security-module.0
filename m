Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215BFC4332F
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Oct 2021 15:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06989610F9
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Oct 2021 15:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbhJMPy3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:54:29 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:37108
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235378AbhJMPyX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Oct 2021 11:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634140339; bh=Pkpc1sMrqsKg4w+957f2M/a84IVZrIfieZFH4qPOQxk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=f4gE1jFU53dWeuzgGQVlSw9gnqn+zgCRrsFAuqwVo0Bf7+HLwvuPea8Hm+91wuD6bhxCzdpS7IHmzB3kcSK3v25IFDQ9KUQH7/KcmkCY+cJhUsQPpa6MV9M00bMbWnPVhhSsdX8IuuyXWioRXYnraG8HPGy6RijmFMS1/GqXeg/gFfXXX3eC5eJRzXsFdHLaMdq+YrxXsrrYVAHx/2P6yNyNv+SyDcGjZlECJ2EReT8w0bZc7KpUR3Bpd29bvDMNgy1+tcLK8DuLJY70hzbMn0PgX0cyWN2bmKUzS9P8ygWZqXuNqqf4y+TfjTkzAJ6t9y4TykjoWHFNQHH6ao34qA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634140339; bh=oV7k0PxqpUtWJfBXyhFDhPks3o65q6h8sNXvtwBB/dH=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=oymhu4NKer7wQ792GurrGE2at5JISQWDCWXMe6+yql7E+lwOzjljYUt0vKQoIrVGlL9uk64osHpS64SA4jZFkm+mjo4KTCIwssz82x0mRicDOe2Pt/zQi8DVySJVRAS62xc3yxZ9KxnWWaZYMqgyQJB74QvsD9adsvMf4js1UADCddYFa28WF61yNGTK5Fv+XvT7195XTXLkvxHEFepnb5b+qvKd+6wTpE4/HTHn3MEFM9UT5/uGwvOKEFM3wlWLBZkqrRKfyTGQensoYH3K9QLJYOSR2crzPW+s2nTzWKGZXIWQ0rO9vRyWyfW2Pv8htQSsY6mQE5VhlCw8FOSQjg==
X-YMail-OSG: s4gb_NAVM1l2JzcRIYUyXWNBomt.Uat7aF1cH8BDvUMh1NZJSKBgYWfzuEsOZxM
 XkvCef2nXr5kScQI1zlqeBU1lAMyvUMvQ.dPO_.HbG3EQlbCNsqc4k4czuWBm2hAoquayB06wBcZ
 4CHVYfvPcsYw0aMoJT1DcOShyi3tGTQY0MStBlU0iUqj9A6MiNrhSvPBrEHTDW5o5KKCvJp8LoBX
 DWIkXfj4lB9m6veLRyTqm.1MfMmC46U45lGzxTWye8it5cqtufT_sZxXxAMS9z6_jK1DFOnJSC.3
 iRvCvJM9Dg66FOJebeK6bevcybjUdNQUHGbEIZLhYEXH1cs8B_rtMPyfGbgn.qywJNq1MYs0q6Vz
 iiibmWzTIRvRUqNuD8Xd.ggmWJUNsFgjGAoUXUl6fKT10zsOZOJY4r9dLjDW_74w5VfXWgH7PCiH
 Av2hZeFmgEPEF.hxopqelcWIRVgZqSZxgGT0R5KBe.1FR322dCZrh3sWPxqTCUxWsRCYCTi67wCf
 t9CSWn0seX6SxA_96Bv17LapTnErR57fhIRqU1KDEWFNQP3ukF_VhcSeutrMTvcxEJVMiU1e1yUO
 cYVDV2x6_pPrjEivv4QiicLIN9kuqs7hnHEISMGXD3crc1QqrIARztBA.kUJLu8FXIyay3LtUDtE
 8cpXTRtT0oJgVotwOEBVKOF6kjhnvXsFEBuFJHRisZxNvo3x.aBvquWK05_W9Ytqg24yG.Y3xvFT
 kODITNhUq_iNfj9zk8a.XL_vjCeJ0gI2TdKHKiztsrxSlF3Z2L_l12fwT9ZhvvKt75Bkid83pkyM
 cMEKdtN1x51f7GHODFDSthWxhzUtHlEF93Wh.vqZH3Yiru.Bz9pHxBMdZ0lV7CmtLXpguFrzV1V9
 aLY2crFd6VAPbqa3hD.rddk0Q_Ltb2AnBnRVQ4irTz8SxRTfgdNnfE0WNOGLfB3JTwRSErnLcDK0
 J0.4YIbvyranpsHRjLXr9ZSsuyN2c5yOWf4pJ.2oh8WvqY88xYc75Q0GUVORbI70u7iwmbzKMiml
 3_ypCJDZW2LRcNgCLUto_1QNmtJK_iklDrBnyLsjEcA2MS3ZwqGTwaaQHbLTc4nKwFEMFCIc16mo
 W_Cd6Wmq6f9DBL0Ipn7NZ8zekQquotZq1O2iO.ceqTG._pBIGYqGYedIlg5fFS133aoZcuasRNmK
 fLnuyOhuNZ_TWTbXxyH_raV0EaHifBSyVpYo2o6.4twSGYCN4DSxJxbv_qWOYGQQKuZd7XPxDnsY
 sht_kkJr5lTf7KDd8DL3cBnrpbf8CK7pk5EraSYaIHVoDLW_GSwUapK1JdoSA2hj65cMefmjbD0x
 Jn9JGxVDV56__B2pC6zCbyROtryeJ7ZwH5EeQVlQ6zBRQTgsDba.voEp8d3Usth9rV5c0vbzeW3S
 En538tDbKIZQ15nOuLVFJ0DU15h_wSGVELGob7mtChtRViHXrBbh_py6GaQUd1183BhAVTH1LPIm
 ol1odVv8IkKJPTE6pTKuqsxp6ZSRKpMc6xNIVhVjEW.S05Cp5YBV2HDQUER61Fh7d_K6y010w4wL
 y0jcITTmUVggTpy8wYq..ZZqly5D8hOsSQgsNn2ZLw1VGUc_ZviX2bv._uOeEzm7Onuil0q.xHxy
 5.6Md9SZELKTfknGnpUP1929z8wkHtnfkED9Wk0phsy5xZjLiqVIWco.UFy2.sWJMUwAPyyzx3Nc
 XLa.qMQT1mMySkORDZzBJw14tECnqkOhP_rbL7fVJhijpvDHBBaWiIk6T1Va_BJ3KsSqkP.bSUuC
 fXB2_wY_u1i.G1GXIP9UVwnrNKP8u_nLOHDNVs41_zkgrllHtXAF7noLrT.NkNmCi9mj8pWuTJpc
 l7_Ehp1ALeUyE7V59WFLmrhWKNUv_9AHO6v_89MEh6kwdN8ZrWnWipPzg53tcpUGnzIo4CXqtYfS
 nd2xKVmwGVgXuQJSthqg1trqpBIxQU08HlBrX4Um7Bp5XkDu.eLERyejUAPH4B1Y0qaFJmO1xn93
 IIZn1qD3Rr3icdQLaubi4Ya15jdQojmrBv_BzyzpfK.395rU4PwOk6ccZYRH3zCjkP3n.gBchU6K
 6ur2zLyQfBbUdJEMBYf.oqsE2r0nhqp1vBPpHmCWD8JjP3HlJUGuOTRmgv87LRr98gSW172U3CSN
 3jOetR_LemkKVjBDqiFo3bkeWbJXCyMv6Gb6ELnyxIcjXhm7YR2R_INWrUDBLHVCTLj9JqfN_XNH
 5CJEUDJimEu0xzDq3npLacVXUrVe8Ow1ZDSQmN9T2_xtonbjDG8BBp4OUPaDORxJXJKDHyy1etXT
 nQfRY_KqKUq5cdyw-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Oct 2021 15:52:19 +0000
Received: by kubenode530.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2bd88d8e0e4903700ed9285dcba3f377;
          Wed, 13 Oct 2021 15:52:16 +0000 (UTC)
Subject: Re: [linux-next:master 1997/7806]
 include/linux/lsm_hook_defs.h:408:18: error: 'uring_sqpoll_default' defined
 but not used
To:     Paul Moore <paul@paul-moore.com>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        KP Singh <kpsingh@chromium.org>,
        Kees Cook <keescook@chromium.org>
References: <202110131608.zms53FPR-lkp@intel.com>
 <CAHC9VhQAkv=jaPM4U1umSXTFtbP4vdXo-tk9vfKGnpAmrxhj1w@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <64f0bc36-ce94-3572-2c07-07e36c34a266@schaufler-ca.com>
Date:   Wed, 13 Oct 2021 08:52:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQAkv=jaPM4U1umSXTFtbP4vdXo-tk9vfKGnpAmrxhj1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19116 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/13/2021 7:57 AM, Paul Moore wrote:
> On Wed, Oct 13, 2021 at 4:17 AM kernel test robot <lkp@intel.com> wrote=
:
>> Hi Paul,
>>
>> FYI, the error/warning still remains.
> I'm not sure if anyone is monitoring the kernel test robot mail, but
> this issue isn't unique to the LSM/audit/io_uring patches, it appears
> to be a general LSM hook issue.

Looks like fallout from KP Singh's MACRO stuff for BPF.

>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-nex=
t.git master
>> head:   8006b911c90a4ec09958447d24c8a4c3538f5723
>> commit: cdc1404a40461faba23c5a5ad40adcc7eecc1580 [1997/7806] lsm,io_ur=
ing: add LSM hooks to io_uring
>> config: microblaze-buildonly-randconfig-r002-20211012 (attached as .co=
nfig)
>> compiler: microblaze-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=3D1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/=
sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-n=
ext.git/commit/?id=3Dcdc1404a40461faba23c5a5ad40adcc7eecc1580
>>         git remote add linux-next https://git.kernel.org/pub/scm/linux=
/kernel/git/next/linux-next.git
>>         git fetch --no-tags linux-next master
>>         git checkout cdc1404a40461faba23c5a5ad40adcc7eecc1580
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.=
cross ARCH=3Dmicroblaze
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> include/linux/lsm_hook_defs.h:408:18: error: 'uring_sqpoll_default' =
defined but not used [-Werror=3Dunused-const-variable=3D]
>>      408 | LSM_HOOK(int, 0, uring_sqpoll, void)
>>          |                  ^~~~~~~~~~~~
>>    security/security.c:706:32: note: in definition of macro 'LSM_RET_D=
EFAULT'
>>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>>          |                                ^~~~
>>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM=
_RET_DEFAULT_int'
>>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>>    include/linux/lsm_hook_defs.h:408:1: note: in expansion of macro 'L=
SM_HOOK'
>>      408 | LSM_HOOK(int, 0, uring_sqpoll, void)
>>          | ^~~~~~~~
>>>> include/linux/lsm_hook_defs.h:407:18: error: 'uring_override_creds_d=
efault' defined but not used [-Werror=3Dunused-const-variable=3D]
>>      407 | LSM_HOOK(int, 0, uring_override_creds, const struct cred *n=
ew)
>>          |                  ^~~~~~~~~~~~~~~~~~~~
>>    security/security.c:706:32: note: in definition of macro 'LSM_RET_D=
EFAULT'
>>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>>          |                                ^~~~
>>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM=
_RET_DEFAULT_int'
>>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>>    include/linux/lsm_hook_defs.h:407:1: note: in expansion of macro 'L=
SM_HOOK'
>>      407 | LSM_HOOK(int, 0, uring_override_creds, const struct cred *n=
ew)
>>          | ^~~~~~~~
>>    include/linux/lsm_hook_defs.h:396:18: error: 'locked_down_default' =
defined but not used [-Werror=3Dunused-const-variable=3D]
>>      396 | LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
>>          |                  ^~~~~~~~~~~
>>    security/security.c:706:32: note: in definition of macro 'LSM_RET_D=
EFAULT'
>>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>>          |                                ^~~~
>>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM=
_RET_DEFAULT_int'
>>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>>    include/linux/lsm_hook_defs.h:396:1: note: in expansion of macro 'L=
SM_HOOK'
>>      396 | LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
>>          | ^~~~~~~~
>>    include/linux/lsm_hook_defs.h:392:18: error: 'bpf_prog_alloc_securi=
ty_default' defined but not used [-Werror=3Dunused-const-variable=3D]
>>      392 | LSM_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_a=
ux *aux)
>>          |                  ^~~~~~~~~~~~~~~~~~~~~~~
>>    security/security.c:706:32: note: in definition of macro 'LSM_RET_D=
EFAULT'
>>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>>          |                                ^~~~
>>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM=
_RET_DEFAULT_int'
>>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>>    include/linux/lsm_hook_defs.h:392:1: note: in expansion of macro 'L=
SM_HOOK'
>>      392 | LSM_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_a=
ux *aux)
>>          | ^~~~~~~~
>>    include/linux/lsm_hook_defs.h:390:18: error: 'bpf_map_alloc_securit=
y_default' defined but not used [-Werror=3Dunused-const-variable=3D]
>>      390 | LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *ma=
p)
>>          |                  ^~~~~~~~~~~~~~~~~~~~~~
>>    security/security.c:706:32: note: in definition of macro 'LSM_RET_D=
EFAULT'
>>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>>          |                                ^~~~
>>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM=
_RET_DEFAULT_int'
>>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>>    include/linux/lsm_hook_defs.h:390:1: note: in expansion of macro 'L=
SM_HOOK'
>>      390 | LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *ma=
p)
>>          | ^~~~~~~~
>>    include/linux/lsm_hook_defs.h:389:18: error: 'bpf_prog_default' def=
ined but not used [-Werror=3Dunused-const-variable=3D]
>>      389 | LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
>>          |                  ^~~~~~~~
>>    security/security.c:706:32: note: in definition of macro 'LSM_RET_D=
EFAULT'
>>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>>          |                                ^~~~
>>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM=
_RET_DEFAULT_int'
>>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>>    include/linux/lsm_hook_defs.h:389:1: note: in expansion of macro 'L=
SM_HOOK'
>>      389 | LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
>>          | ^~~~~~~~
>>    include/linux/lsm_hook_defs.h:388:18: error: 'bpf_map_default' defi=
ned but not used [-Werror=3Dunused-const-variable=3D]
>>      388 | LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmod=
e)
>>          |                  ^~~~~~~
>>    security/security.c:706:32: note: in definition of macro 'LSM_RET_D=
EFAULT'
>>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>>          |                                ^~~~
>>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM=
_RET_DEFAULT_int'
>>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>>    include/linux/lsm_hook_defs.h:388:1: note: in expansion of macro 'L=
SM_HOOK'
>>      388 | LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmod=
e)
>>          | ^~~~~~~~
>>    include/linux/lsm_hook_defs.h:387:18: error: 'bpf_default' defined =
but not used [-Werror=3Dunused-const-variable=3D]
>>      387 | LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsign=
ed int size)
>>          |                  ^~~
>>    security/security.c:706:32: note: in definition of macro 'LSM_RET_D=
EFAULT'
>>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>>          |                                ^~~~
>>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM=
_RET_DEFAULT_int'
>>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>>    include/linux/lsm_hook_defs.h:387:1: note: in expansion of macro 'L=
SM_HOOK'
>>      387 | LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsign=
ed int size)
>>          | ^~~~~~~~
>>    include/linux/lsm_hook_defs.h:382:18: error: 'audit_rule_match_defa=
ult' defined but not used [-Werror=3Dunused-const-variable=3D]
>>      382 | LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u3=
2 op, void *lsmrule)
>>          |                  ^~~~~~~~~~~~~~~~
>>    security/security.c:706:32: note: in definition of macro 'LSM_RET_D=
EFAULT'
>>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>>          |                                ^~~~
>>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM=
_RET_DEFAULT_int'
>>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>>    include/linux/lsm_hook_defs.h:382:1: note: in expansion of macro 'L=
SM_HOOK'
>>      382 | LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u3=
2 op, void *lsmrule)
>>          | ^~~~~~~~
>>    include/linux/lsm_hook_defs.h:381:18: error: 'audit_rule_known_defa=
ult' defined but not used [-Werror=3Dunused-const-variable=3D]
>>      381 | LSM_HOOK(int, 0, audit_rule_known, struct audit_krule *krul=
e)
>>          |                  ^~~~~~~~~~~~~~~~
>>    security/security.c:706:32: note: in definition of macro 'LSM_RET_D=
EFAULT'
>>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>>
>>
>> vim +/uring_sqpoll_default +408 include/linux/lsm_hook_defs.h
>>
>>    405
>>    406  #ifdef CONFIG_IO_URING
>>  > 407  LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)=

>>  > 408  LSM_HOOK(int, 0, uring_sqpoll, void)
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
>

