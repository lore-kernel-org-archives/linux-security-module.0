Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5DEC433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 18:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE7064ECB
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 18:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhBVSbs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Feb 2021 13:31:48 -0500
Received: from smtp-8fa9.mail.infomaniak.ch ([83.166.143.169]:41649 "EHLO
        smtp-8fa9.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232772AbhBVSbh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Feb 2021 13:31:37 -0500
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DkrN30fH2zMqDYj;
        Mon, 22 Feb 2021 19:30:43 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4DkrN14dNkzlppyp;
        Mon, 22 Feb 2021 19:30:41 +0100 (CET)
Subject: Re: [PATCH v3 1/1] security: Add CONFIG_LSM_AUTO to handle default
 LSM stack ordering
To:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20210222150608.808146-1-mic@digikod.net>
 <20210222150608.808146-2-mic@digikod.net>
 <51725b44-bc40-0205-8583-285d3b35b5ca@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <ee461f8d-a02d-0782-8f31-691853a57f00@digikod.net>
Date:   Mon, 22 Feb 2021 19:31:58 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <51725b44-bc40-0205-8583-285d3b35b5ca@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 22/02/2021 17:51, Casey Schaufler wrote:
> On 2/22/2021 7:06 AM, Mickaël Salaün wrote:
>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>
>> Add a new option CONFIG_LSM_AUTO to enable users to delegate default LSM
>> stacking order to kernel developers.  This enable to keep a consistent
>> order of enabled LSM when changing the LSM selection, especially when a
>> new LSM is added to the kernel.
> 
> TL;DR - NAK
> 
> Do you think that we might have considered this when stacking was
> introduced?

I didn't dig the detailed history of LSM stacking, but you are in Cc
because I know that you know. I may have though that the main goal of
the current LSM stacking implementation was to enable to stack existing
LSMs, which works well with this CONFIG_LSM list, but doesn't work as
well for new LSMs.

> Did you even consider the implications before sending
> the patch?

Yes, and it doesn't change much the current behavior without user
interaction. However, it gives the choice to users to choose how they
want their configuration to evolve.

> This only makes any sense if you want to compile in
> AppArmor and/or Smack but always use SELinux. The existing Kconfig
> model handles that perfectly well.

This patch series doesn't change this behavior if the user doesn't want
it to change.

> Also, this will break when the
> next phase of module stacking comes in, and all of a sudden
> systems will automatically get AppArmor in addition to SELinux
> or Smack.

What is the next phase of module stacking? What would be the consequences?

Systems will only get new LSMs if their configuration said so, either
from Kconfig or from boot arguments. I think we should make easier to
have a working, consistent and secure kernel configuration by default.
If users want to have a non-default configuration, that's fine, fully
supported, and they can do it.

> 
> I know that the CONFIG_LSM/lsm= mechanism is clumsy. But we spent
> about a year discussing, proposing and implementing alternatives,
> and if there's a better mechanism, we couldn't find it. Of course
> we considered "just use the kernel order".

This is indeed the intent of this patch, but this configuration is optional.

> It doesn't work for generic kernels.

Why? Generic kernels can be configured with CONFIG_LSM or with
CONFIG_LSM_AUTO. I agree that generic distros may want to not enable
major LSMs such as SELinux, AppArmor, Smack and Tomoyo by default but
support them in their generic kernel anyway to let users pick and
configure an LSM thanks to the boot arguments, and that's totally fine.
Moreover, distro maintainers will surely browse most of new options to
identify if it is the best choice for their distro. The *default* choice
(for LSMs enabled at boot) is in the hand of users configuring their
kernel, and they are in the best position to choose if they want to
follow new kernel options and their consequences (e.g. distro kernel
maintainers, whose job is to follow kernel development), or to have an
easier way to maintain an up-to-date kernel (e.g. sysadmins or
hobbyists, who may not have so much time dedicated to follow kernel
developments).

> I understand that adding a new LSM that you want
> to be included by default is a tough problem. I also suggest
> that silently adding an LSM to an existing configuration is likely
> to violate the principle of least astonishment.

Nothing is silently added to the user configuration with this patch. It
is an optional (default) configuration, which I think makes more sense
for users not expert in every kernel toggles.

> 
>>
>> CONFIG_LSM depends on !CONFIG_LSM_AUTO, which is backward compatible and
>> gives the opportunity to users to select CONFIG_LSM_AUTO with a make
>> oldconfig.
>>
>> CONFIG_LSM and CONFIG_LSM_AUTO depend on CONFIG_SECURITY, which makes
>> sense because an LSM depends on the security framework.
>>
>> Cc: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Serge E. Hallyn <serge@hallyn.com>
>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>> Link: https://lore.kernel.org/r/20210222150608.808146-2-mic@digikod.net
>> ---
>>
>> Changes since v2:
>> * Revamp without virtual dependencies but a new option to automatically
>>   enable all selected LSMs.
>>
>> Changes since v1:
>> * Add CONFIG_SECURITY as a dependency of CONFIG_LSM.  This prevent an
>>   error when building without any LSMs.
>> ---
>>  security/Kconfig    | 19 +++++++++++++++++++
>>  security/security.c | 26 +++++++++++++++++++++++++-
>>  2 files changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/security/Kconfig b/security/Kconfig
>> index 7561f6f99f1d..fae083e9867d 100644
>> --- a/security/Kconfig
>> +++ b/security/Kconfig
>> @@ -243,6 +243,7 @@ source "security/integrity/Kconfig"
>>  
>>  choice
>>  	prompt "First legacy 'major LSM' to be initialized"
>> +	depends on SECURITY
>>  	default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
>>  	default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
>>  	default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
>> @@ -275,8 +276,26 @@ choice
>>  
>>  endchoice
>>  
>> +config LSM_AUTO
>> +	bool "Automatically enable all selected LSMs at boot"
>> +	depends on SECURITY
>> +	default y
>> +	help
>> +	  This automatically configure the build-time selected LSMs to be
>> +	  enabled at boot unless the "lsm=" parameter is provided.
>> +
>> +	  If this option is not selected, it will be required to configure and
>> +	  maintained a static list of enabled LSMs that may become inconsistent
>> +	  with future user configuration.  Indeed, this list will not be
>> +	  automatically upgraded when selecting a new (future) LSM, e.g. with
>> +	  make oldconfig.
>> +
>> +	  If you are unsure how to answer this question, answer Y.
>> +
>> +# This lists should be synchronized with LSM_ORDER defined in security/security.c .
>>  config LSM
>>  	string "Ordered list of enabled LSMs"
>> +	depends on SECURITY && !LSM_AUTO
>>  	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
>>  	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
>>  	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
>> diff --git a/security/security.c b/security/security.c
>> index 401663b5b70e..defa1d2c40a3 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -82,7 +82,31 @@ static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
>>  static __initdata const char *chosen_lsm_order;
>>  static __initdata const char *chosen_major_lsm;
>>  
>> -static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
>> +#ifdef CONFIG_LSM
>> +#define LSM_ORDER	CONFIG_LSM
>> +#else
>> +
>> +/*
>> + * This lists should be synchronized with the default values of CONFIG_LSM
>> + * defined in security/Kconfig .
>> + */
>> +#define LSM_ORDER_PRE	"lockdown,yama,loadpin,safesetid,integrity,"
>> +
>> +#if defined(CONFIG_DEFAULT_SECURITY_SMACK)
>> +#define LSM_ORDER	LSM_ORDER_PRE "smack,selinux,tomoyo,apparmor,bpf"
>> +#elif defined(CONFIG_DEFAULT_SECURITY_APPARMOR)
>> +#define LSM_ORDER	LSM_ORDER_PRE "apparmor,selinux,smack,tomoyo,bpf"
>> +#elif defined(CONFIG_DEFAULT_SECURITY_TOMOYO)
>> +#define LSM_ORDER	LSM_ORDER_PRE "tomoyo,bpf"
>> +#elif defined(CONFIG_DEFAULT_SECURITY_DAC)
>> +#define LSM_ORDER	LSM_ORDER_PRE "bpf"
>> +#else
>> +#define LSM_ORDER	LSM_ORDER_PRE "selinux,smack,tomoyo,apparmor,bpf"
>> +#endif
>> +
>> +#endif /* CONFIG_LSM */
>> +
>> +static __initconst const char * const builtin_lsm_order = LSM_ORDER;
>>  
>>  /* Ordered list of LSMs to initialize. */
>>  static __initdata struct lsm_info **ordered_lsms;
> 
