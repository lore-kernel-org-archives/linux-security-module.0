Return-Path: <SRS0=lArx=4G=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA7BC3403B
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Feb 2020 14:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAD520801
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Feb 2020 14:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="fmakFKkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgBROCX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:02:23 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:42176 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgBROCX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Feb 2020 09:02:23 -0500
X-EEMSG-check-017: 59495269|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="59495269"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Feb 2020 14:02:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582034533; x=1613570533;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=BAxsEBtDEJviZluZ3jqeYHvGG1lj7nXMWftotAly9Io=;
  b=fmakFKkv5ErS+mpsto9JhWrYtPojns3/v7AxJpRglTWaavQB1NasBY7N
   ClRLoVG31N71y+CYgcV4oR+lu0p179MWUpuaXnM/Zx1uPxoHPsiaHLH29
   CQHAu0ynROj39wvTz49z3k2f1UsnTUcFNFn8IriC6dm3aMYE9hbllpcWk
   fLAOVfJR379lr0cl4RVc95VB6U6ctob5UGnaiKrTEK25uZaIuC0lR4s7+
   uVrtWexUJmIdpJY7E5L/woXiSq7Lrh8EB8qMlu+RsSHrNfehahPlVRBp6
   WwCTZP7fGwbkORql1fmkaBZQJNEwDMoguB6y/BobSFLpbqzJ7ttq9QqO1
   A==;
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="39219569"
IronPort-PHdr: =?us-ascii?q?9a23=3AB7XrfRN939Fsew6EXHQl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/rzoMbcNUDSrc9gkEXOFd2Cra4d16yJ4+u9CSQp2tWojjMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIxi6twfcu8oZjYZiKas61w?=
 =?us-ascii?q?fErGZPd+lKymxkIk6ekQzh7cmq5p5j9CpQu/Ml98FeVKjxYro1Q79FAjk4Km?=
 =?us-ascii?q?45/MLkuwXNQguJ/XscT34ZkgFUDAjf7RH1RYn+vy3nvedgwiaaPMn2TbcpWT?=
 =?us-ascii?q?S+6qpgVRHlhDsbOzM/7WrakdJ7gr5Frx29phx/24/Ub5+TNPpiZaPWYNcWSX?=
 =?us-ascii?q?NcUspNSyBNB4WxYIUVD+oFIO1WsY/zqVUTphe6HAWgGefixjpOi3Tr36M1zv?=
 =?us-ascii?q?4hHBnb0gI+EdIAsHfaotv7O6gdU++60KbGwC7fb/5Uwzrx9JTEfx4jrPyKQL?=
 =?us-ascii?q?l+cdDRyU4qFw7dk1uQtZLqPyuV1usTtWiQ8vduVee1hG4jrwF+vDiuzdorh4?=
 =?us-ascii?q?nSm40V0UvJ9Tl5wYkpJd24T1R3Ydi/EJRKrS2aOIx2Qt07TmxupS00yaUGtI?=
 =?us-ascii?q?amcCUFx5kr3R7SZ+Gdf4SW7R/vSvydLSp+iXl4YrywnQyy/lKlyuDkU8m010?=
 =?us-ascii?q?tFoTRdn9nXs3ANywTT6s+aSvth5kuh2SiA1wTU6uxcPUA7j7DbK588wr4rjJ?=
 =?us-ascii?q?YTsELDHiHxmEXtkqCZal8o+vSo6uv7YrXmoYWQN4lohQHlLqsigMm/AeU8Mg?=
 =?us-ascii?q?QWXmib//qz1KH78EHkT7hHgec6n6nEvJzAO8gWqbC1DxVI3oo77hawFTam0N?=
 =?us-ascii?q?AWnXkdK1JFfQqKj5P0NFHVO/34Efe+jEiskDds3fzGOKbhDY/XInjMl7fhY6?=
 =?us-ascii?q?5x61RAxwor0dBf+5VUB6kbIP3uR0/xstjYAQUhMwGvwubnDtt91pkEVm2SHK?=
 =?us-ascii?q?CWKr7dvUWP5uI1LOmGfJUVtyrlK/g5+/7uimc0mVscfamvwJsWZ2m0Hvd4LE?=
 =?us-ascii?q?WDZ3rjnNMBHHwUvgoxUuPqkkeOUT1NaHaoWaIz+DU7BJihDYfZSYCnmKaB0z?=
 =?us-ascii?q?ujHp1KemBGDUiBEXPpd4WCRvcNZzueItR/nTMYSLihUY4h1Q2utQPjzrpnKf?=
 =?us-ascii?q?fb+jActZ39z9V1+eLTmg8o9TBuDMSSzXuNT2dqkWMMXTM227p/oUNlwFeZza?=
 =?us-ascii?q?d4m+BYFcBU5/5RUAc6Mp7cz+pgB9DwXQLBfs2GSFC9Qtq4BzE8Vc4+zMUIY0?=
 =?us-ascii?q?Z6HdWijwzM0DCuA7MPi7OLA5k0+LrG33ftP8Z912rG1K45glklXMRAK3amib?=
 =?us-ascii?q?J49wjUBI7EiFmWl6awdaQb2S7N9XqDzW+UsEFfSg5wXr3PXWoDaUvOsdT5+k?=
 =?us-ascii?q?TCQqerCbQgKAtB1cmCKq1PatDykVpGRO3jONPbY2KwhmewAAyExrSWbIrlY2?=
 =?us-ascii?q?8dxjnSCFAYkwAP+naLLQo+BiKmo2LEFjxuFEnvbljq8eZkrXO0UE40wxuNb0?=
 =?us-ascii?q?172Lq/4gQViuCES/MPwrIEvz8sqy5qE1an0NLZFcGNpwp7c6VYZdM84FFH2X?=
 =?us-ascii?q?jFuAx6O5yqN7piiUIGcwRro0Pu0A16Cp1ansg3qHMn1xJyJriF0FNFbj+Y2J?=
 =?us-ascii?q?fwOrrNKmbs5hygd6nW2lTG2taM5qgP8Og4q0nkvAyxCEUi629o08NU03uH/Z?=
 =?us-ascii?q?jKFBAdUYjwUkYs7xh6o6vVbTUj6I/O0n1sK6a0uCfY2901HOsl1gqgf9BHPa?=
 =?us-ascii?q?yYDgDyCNMVBsi1Jewxh1epbggLPP1c9K4wIcymbeKK17KxM+p6gD2mimFH6p?=
 =?us-ascii?q?hn0k2Q7yp8VvLI35EdzvGExASHVCnzg0q7vcD0n4BJfjcSHnajySf5HoFRer?=
 =?us-ascii?q?d9cZwXBmepOcG3xM1+jYb3W3FE7F6jG08G2MixdBqKcVP92wJQ1VkWoXyhgC?=
 =?us-ascii?q?e4zCJ7kysvrqWB2CzD2OXieAMDOm5MWmltk03gIZOugNAZQUiodRImmAGj5U?=
 =?us-ascii?q?nk3aRbprx/fCHvRhJydi76PilOT620v6LKN9RD9ZUsuD1/UeKye1mWR7fx5R?=
 =?us-ascii?q?wA3HWnV0994RRzIzWrvIjp2h93kmSQKF5to3fDP8J93xHS4JrbX/EHmnICRS?=
 =?us-ascii?q?9lmXzMC1OhJdi17JCRkJvetu32A2agUIBDNDLmxp6atTeqoGhtDQC7ktitld?=
 =?us-ascii?q?D9Vws3yyn2059tTyqe/zjmZYy+7Li3KeJqeAFTAVb478drUtVlnpAYmIAb2X?=
 =?us-ascii?q?9cgI6cu3UAjzGgYp1gxaviYS9VFnYwyNnP7V2ggRQyIw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CFAgD77Ute/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBSJA4ZhBoE3iXCRSgkBAQEBAQEBAQE3BAEBhEACgic4EwIQAQEBB?=
 =?us-ascii?q?QEBAQEBBQMBAWyFQ4I7KQGDAQEBAQEDIxVBEAsOBwMCAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?mM/glclq1F1gTKFSoNqgT6BDiqMPnmBB4E4D4JdPoQSg0mCPCIEkCKHMEaXc?=
 =?us-ascii?q?oJFglCUAwYchw+UFy2OQJ1PIoFYKwgCGAghD4MnUBgNnQEjAzANjj2CQwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Feb 2020 14:02:01 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01IE0hBe258104;
        Tue, 18 Feb 2020 09:00:45 -0500
Subject: Re: [RFC PATCH] security: <linux/lsm_hooks.h>: fix all kernel-doc
 warnings
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <fb2c98bd-b579-6ad0-721a-56a4f81f0d6e@infradead.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ec4e5117-08b6-d4df-fb08-deb553ebdc73@tycho.nsa.gov>
Date:   Tue, 18 Feb 2020 09:03:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fb2c98bd-b579-6ad0-721a-56a4f81f0d6e@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/16/20 2:08 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix all kernel-doc warnings in <linux/lsm_hooks.h>.
> Fixes the following warnings:
> 
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'locked_down' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_open' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_alloc' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_free' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_read' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_write' not described in 'security_list_options'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Micah Morton <mortonm@chromium.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Notes:
> a. The location for some of these might need to be modified.
> b. 'locked_down' was just missing a final ':'.
> c. Added a new section: Security hooks for perf events.
> 
>   include/linux/lsm_hooks.h |   36 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 35 insertions(+), 1 deletion(-)
> 
> --- lnx-56-rc1.orig/include/linux/lsm_hooks.h
> +++ lnx-56-rc1/include/linux/lsm_hooks.h
> @@ -136,6 +140,10 @@
>    *	@sb superblock being remounted
>    *	@data contains the filesystem-specific data.
>    *	Return 0 if permission is granted.
> + * @sb_kern_mount:
> + * 	Mount this @sb if allowed by permissions.
> + * @sb_show_options:
> + * 	Show (print on @m) mount options for this @sb.
>    * @sb_umount:
>    *	Check permission before the @mnt file system is unmounted.
>    *	@mnt contains the mounted file system.

Thanks for doing this.  Note that some of the existing kernel-doc 
comments for these hooks include a separate line describing each 
parameter (not just embedded in the function description) and a line 
describing the return value.  Is that optional for kernel-doc? 
Obviously what you have added here is an improvement, just wondering 
whether it suffices or needs further augmentation.
