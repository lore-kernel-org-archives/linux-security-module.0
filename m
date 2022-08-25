Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC836C28D13
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Aug 2022 15:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242884AbiHYP7o (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Aug 2022 11:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242910AbiHYP7m (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Aug 2022 11:59:42 -0400
Received: from sonic302-27.consmr.mail.ne1.yahoo.com (sonic302-27.consmr.mail.ne1.yahoo.com [66.163.186.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24738B2852
        for <linux-security-module@vger.kernel.org>; Thu, 25 Aug 2022 08:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661443179; bh=FgkKfWmaqFZwEt1b7gidOho8J7CczDq8sRmIBF8+SR0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=l1eO9+4qcXkNfA0RBYlds5hsYDmQP0BCjT3KUz42KJcaAlAjA03qq1UhNUTOsHxwpOegGm2TM4IemDQ36fLNbJMZWgZKs0Z60P+v2oQ471cCy2mj6ALAvavKotWhXxebpGMpiEE/LpsxSOMzXSlggmWsSd8VQkBmM0hxDv+341j5DpuKawqTQoguDd4AI0cyJqZGYssvPOPIdCh3OoK00ZivKm3/MGD+ZdP0rcHImcmjvI/NSGsxFULfA7Y3tmW/2j9/aUjleAbT6K4r/tJAgvn+GcQHCoAG+05WSiUsiYg1VSmxy8KbFJO9ZuVmoX8LOS42b9rSbzlPo3XRyOqIZw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661443179; bh=sOkN6GRl7cb6BnzxKY8TG+OmCtbVnxPKpEEmGaFWuhd=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=DogGxwSERKW9X0mZWXQmW8QrlLfuls75QRdM4E6DQItqfxNUxwwt2gX42vCVwvkil7rXnSQe89zWKhWdW6TZ8nYRyWFH+reBlxK9geFJSf4080SZkSdspqUdZd8ysQobtZQ5616hqnKrtPOTM+qhgp53CHwiXzF9FgnqwqK23B/YyQLbuLZ7LPWx1Etp30inaxmFeF+GqrrtJL/RPukwPt8d0p8PHsXXXUCBco3M8YfkkacST5HtWh4vyiu3sYN8eCILhXDV+uNdjEr0yVOKedmzXkcNA4woiLZADWIEKtowPUyDl0yeEyShBujPWpSieTHT6WlUuclb337KB9Uu2A==
X-YMail-OSG: ah5OIhYVM1ngkHyD3iJoUn8QH_eXiu7wJ6bwNIL7pvP.cbiijCbhLkHoVl37LOW
 ens7bSQrAcXrAKQboqFRxPteKTPcvX2gLVw7NZy2CcMHdbjviBEZPWdKsbhRXeCKYy.jhMmtUr7N
 4B_DPb8LNW8NQOHbiBS2aAhpnQvs3zx.B1xtv2Awku01STjArbS0KvhyefazZRcmGKwrkT3xD5qR
 zHBB5QMYxAyZY5j_kL4OuOABIlKbyUZYREc1Kwe.O2eGXGg5MHstlDycFz5A2mRS855Yq_7n.Dtt
 AY0Ba6qsK6BOsUaIJYGyZyD7jhv.zWV6IATTW4aB6p6d1d_2mabPTFIEgRyJ7U1.6phEmMDgJErN
 BDvBOYC_RiEYj9tj1JomUXehHrkOj.mzxpLRBKzjIiKTlUM4V9ZifH5Vu3Xq4tnJsWA7_z_OdI9E
 Tfe_U0oJkhZYcPFnCBMjKM1B1jFJkCJFEkNrih_MbWp9k9jlkqM_LcccFjAUMtkfK1BsgEUrqb0G
 FfBNQ.H_M3ZUFEjmqeEW9Es8xEG0kJ05eavGKHozN0UqwrqgCScNOVHBBgwhTW8fAYG4PFSYQvYY
 cdgvhBlb8al5C2fEIx5e56FBKctfcHSEFXfOAlS3tLXv.ibadtLxRUIrB9KjoVoj48jrUjqfN3kK
 Uu.kxrzGcF8XM98OyZ4w5_t6ElrVj0238DZ9TCXR.Z8gKQeSDCd6kZIbhq8ebqWjlVxU0dIhmHnu
 GS49ljjx3OF.avASaMSsj7HWwGywYuNxKhplMmlgPsUbw6mwwJHvTGr87f4OMw8COif4gvUBbw9P
 XUq4il1jitxVMvCXtPwGr_dyIvPBhEV.y2LHrRRAGHmOQFwBVnvArvYx7btAAwNDGG8c74Zf5pFi
 1tXrZOE4lQOKkD7kDb0UsrSy.c2C6HwHF_cMvK65XhzOsRx5HhwQPN4trtlIJ95JStrWfZEj0sae
 L9E3NLaont2iZza91_BMN54Y5f.__qYHyuLb6nNp0Z24ImHSs9dbI6YRL3IxdcQPzOLR0oI7n7.B
 k8wI1BW5xhjLGymnr6ftNjHHPvQLUSLfJaS.Gebwb6EJi_Hpn.VJhvtr552I8Ll36BCwXuIe4JgH
 t7XIKTaiC6qAflIozfaxdIazi6lzM3wwaYrZFQTRzEWBJBHRHdxUbHmVrE4W3fNhlJ8rN9k.B8AZ
 I.FTB1NkSTBlD4GIA4.hLjpXEH2uaPyURvpsOfcUQ5sKgaT6W9G9bvHliCf3IfjPaxwZXwLJvnWr
 NeXW.MZYPUegyeM4MYwkcjRMRxzNBzBzieA5W8dZyfRmjsUd6yHGkwBnDU19Xx93FVFKhq.EOp6I
 liRoRF2w_g3aDal4WXYT85S.EUuygTzKhOhrg54hK46.ay_knkoHOlw9DdBGzM791LK2TYJ5b1c4
 i_hDIr5mAuegv7EM9o3tJydspRYD6TxHmR0b1JmXrKyHfI.62boZIzxi1COcl6k69fZmTaE6V9Y.
 HHaz2ZuD7hDvxbiZSrCb6p_8wbzisUmMjjrl87oqO875ayOhoChACtKXOt1fBPacjo8PPSvKZZyA
 CYh1uS3rG0vepr17OVBLKuu87gPerBydl7JNF3wi5dnXMN9m3ilYB8B2q1nAR4akHka00GhfXKPz
 jFYREdyoYYoVtGpOsZZ.22esA3qcvNixkKccfrYVl6ySBg4U4jpltIyN.8.bXkn_1X6tYt4I3DVQ
 LNfAvoZjn_F1arct8Zlbezms_4eTbE1FGKCOIuzDJyJXb1usMdrdlkJQHQfO91ISadYeCj87D34P
 DDEtfr4bmKhdvSj5Kf9OhNBFm.A4l3GlNX97NxAqiEd7GtOraDFi2FUThudRDd0_pecqOuZh6nFM
 pTMPeIBRGqHxg5.Ja7wkwxUZJMlxgRE0QTRc52k4Yl6.EBuBQtD2khr3Y6f2q7pG0VJgmDdz6WER
 g5DVgbs40Z3oXItJ8pk4N2qhtD.61QbTjVRrEPYFhKzAJ_6NOybEt0ghCaRPwxiKLG4wQNM661E6
 31s54MEYcrVLDBnq.cUYeESu56.ZxxJr49NIsLL_gEqv9dlB6HcxxVLHyDEIcpDpNChmoEY17WWj
 MjNExoGWI1xSOmPR0zdKHb2NWIHiNzz6HgeznZqMHi8KqymBhKla26OzhLSZwuWrmneZ7lAE_oC_
 NxSaZkJzOe1e54gyIDGRn7KOmDCG1UUiVNqCZacneQIAc8f51f3gFcnZQuBHwBdqe18AZ7Mflv6H
 mNONW8pAlqy9bQzoGM0dnCaKnnpJ1
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Thu, 25 Aug 2022 15:59:39 +0000
Received: by hermes--production-ne1-6649c47445-kh29z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a9d38b577c0296dd5888cce638a1b8e6;
          Thu, 25 Aug 2022 15:59:37 +0000 (UTC)
Message-ID: <7fabf823-bdac-789a-09fb-325e60e79976@schaufler-ca.com>
Date:   Thu, 25 Aug 2022 08:59:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: SMACK LSM checks wrong object label during ingress network
 traffic
Content-Language: en-US
To:     "Lontke, Michael" <Michael.Lontke@elektrobit.com>
Cc:     "Ostertag, Martin" <Martin.Ostertag@elektrobit.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        =?UTF-8?Q?Wei=c3=9f=2c_Simone?= <Simone.Weiss@elektrobit.com>,
        "Valleru, Yuvarajesh" <Yuvarajesh.Valleru@elektrobit.com>,
        "Irgang, Thomas" <Thomas.Irgang@elektrobit.com>,
        casey@schaufler-ca.com
References: <0ff932aeb13400fcbb8b1ce346504e860cb031b9.camel@elektrobit.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <0ff932aeb13400fcbb8b1ce346504e860cb031b9.camel@elektrobit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20560 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 8/25/2022 2:25 AM, Lontke, Michael wrote:
> Hello Mr. Schaufler,
>
> we observed the following behavior of the SMACK LSM kernel feature.
>
> PROBLEM: SMACK LSM is checking the wrong label when receiving network
> packets during high system load.
>
> Full Descrpition of the Problem: During a test scenario involving high
> system load (cpu, memory and io) in combination with ingress tcp
> network traffic, SMACK is checking wrong object labels leading to
> denied access for valid scenarios.
> In below test scenario the label 'stresstest' is only used for the
> application 'stress' but appears in SMACK audit logs as object together
> with netlabels.
>
> This issue initially appeared on hardware with kernel version 4.14.237
> but was also being reproduced with qemu for kernel version 4.14.290 and
> latest 6.0-rc2. The used rootfs was generated via buildroot version
> 2022.08-rc1.
>
>
> KEYWORDS: smack, networking
>
> KERNEL INFORMATION: Linux stable kernel
>
> KERNEL VERSION: 4.14.237, 4.14.290, 6.0-rc2
>
>
> KERNEL CONFIG: smack related kernel configuration
>
> CONFIG_NETLABEL=y
>
> CONFIG_SECURITY_NETWORK=y
>
> CONFIG_SECURITY_SMACK=y
>
> CONFIG_DEFAULT_SECURITY_SMACK=y
>
> CONFIG_DEFAULT_SECURITY="smack"

What is the value for CONFIG_SECURITY_SMACK_NETFILTER ?
The implementation for IPv6 is much more robust for the
netfilter enabled path. 

> CONFIG_CRC_CCITT=y
>
> CONFIG_EXT4_FS_SECURITY=y
>
> CONFIG_TMPFS_XATTR=y
>
> CONFIG_SQUASHFS_XATTR=y
>
>
> Steps to reproduce the issue:

Thank you for the detailed report. I will look into
the problem today.

> On qemu:
> * Setup qemu with network connection to the host via tap device.
> * Add ip6host label via smackfs:
>
> echo "<host-ipv6-addr> net_host" > /sys/fs/smackfs/ipv6host
>
> * Add rule for allowed network traffic:
>
> echo "tcp_test net_host w" > /sys/fs/smackfs/load2
>
> * The following script was used for listening for packets on qemu:
>
> cat << EOF > tcp_listen.sh
> #!/bin/sh
> while true;
> do
>     socat - TCP6-LISTEN:\$1,reuseaddr,fork > /dev/null & ps=\$!
>     sleep 1
>     kill -9 \$ps
> done
> EOF
>
> * Start the script twice, one allowing, one denying traffic via SMACK:
>
> echo tcp_test > /proc/self/attr/current && sh tcp_listen.sh 12345 2>&1
> /dev/null &
> echo tcp_test2 > /proc/self/attr/current && sh tcp_listen.sh 12346 2>&1
> /dev/null &
>
> * Start 'stress' to generate system load with 'stresstest' as SMACK
> label:
>
> echo stresstest > /proc/self/attr/current && stress -c 2 -i 4 -m 2 --
> vm-bytes 64M &
>
>
> On host:
> * Generate random data to send via network:
>  
> dd if=/dev/urandom of=test/data bs=1M count=10
>
> * Use the following script to continously send packets:
>
> cat << EOF > packet_tcp.sh
> #!/bin/sh
> while true;
> do
>     cat data | nc <qemu-ipv6-addr> \$1
> done
> EOF
>
> * Execute the script twice to address both receiving applications on
> qemu:
>
> bash packet_tcp.sh 12345 2>&1 > /dev/null &
> bash packet_tcp.sh 12346 2>&1 > /dev/null &
>
>
> Observing the problem:
>
> After letting this run for ~5-10 mins only audit messages regarding the
> label 'tcp_test2' are expected.
> The issues can be seen, that also other labels are randomly appearing
> in the logs (most commonly here 'stresstest', probably since it
> occupies most of the cpu time):
>
> journalctl | grep action=denied | grep -v tcp_test2
>
>
> Example entry with kernel 6.0-rc2:
> Aug 24 12:38:32 buildroot audit[609]: AVC lsm=SMACK fn=smk_ipv6_check
> action=denied subject="net_host" object="stresstest" requested=w
> pid=609 comm="stress" saddr=<host-ipv6-addr> dest=50714

This may be an issue with the audit record generation including the
wrong object label. It has been noticed before. I will look more closely.

> If you are missing additional info please reach out to me.
> Thank you in advance and best regards,
>
> Michael Lontke
