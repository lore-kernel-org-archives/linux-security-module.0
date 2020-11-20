Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C56C56202
	for <linux-security-module@archiver.kernel.org>; Fri, 20 Nov 2020 03:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A9422210
	for <linux-security-module@archiver.kernel.org>; Fri, 20 Nov 2020 03:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgKTDRF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 19 Nov 2020 22:17:05 -0500
Received: from namei.org ([65.99.196.166]:54356 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgKTDRE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 19 Nov 2020 22:17:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0AK3GrqJ021162;
        Fri, 20 Nov 2020 03:16:53 GMT
Date:   Fri, 20 Nov 2020 14:16:53 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     "Serge E. Hallyn" <serge@hallyn.com>
cc:     lkml <linux-kernel@vger.kernel.org>,
        =?ISO-8859-15?Q?Herv=E9_Guillemet?= <herve@guillemet.org>,
        "Andrew G. Morgan" <morgan@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] fix namespaced fscaps when !CONFIG_SECURITY
In-Reply-To: <20201117150856.GA12240@mail.hallyn.com>
Message-ID: <alpine.LRH.2.21.2011201416420.20300@namei.org>
References: <20201117150856.GA12240@mail.hallyn.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-1261770800-1605842213=:20300"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1261770800-1605842213=:20300
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

[Adding LSM list]

On Tue, 17 Nov 2020, Serge E. Hallyn wrote:

> Namespaced file capabilities were introduced in 8db6c34f1dbc .
> When userspace reads an xattr for a namespaced capability, a
> virtualized representation of it is returned if the caller is
> in a user namespace owned by the capability's owning rootid.
> The function which performs this virtualization was not hooked
> up if CONFIG_SECURITY=n.  Therefore in that case the original
> xattr was shown instead of the virtualized one.
> 
> To test this using libcap-bin (*1),
> 
> $ v=$(mktemp)
> $ unshare -Ur setcap cap_sys_admin-eip $v
> $ unshare -Ur setcap -v cap_sys_admin-eip $v
> /tmp/tmp.lSiIFRvt8Y: OK
> 
> "setcap -v" verifies the values instead of setting them, and
> will check whether the rootid value is set.  Therefore, with
> this bug un-fixed, and with CONFIG_SECURITY=n, setcap -v will
> fail:
> 
> $ v=$(mktemp)
> $ unshare -Ur setcap cap_sys_admin=eip $v
> $ unshare -Ur setcap -v cap_sys_admin=eip $v
> nsowner[got=1000, want=0],/tmp/tmp.HHDiOOl9fY differs in []
> 
> Fix this bug by calling cap_inode_getsecurity() in
> security_inode_getsecurity() instead of returning
> -EOPNOTSUPP, when CONFIG_SECURITY=n.
> 
> *1 - note, if libcap is too old for getcap to have the '-n'
> option, then use verify-caps instead.
> 
> Signed-off-by: Serge Hallyn <serge@hallyn.com>
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1593431
> Cc: Hervé Guillemet <herve@guillemet.org>
> Cc: Andrew G. Morgan <morgan@kernel.org>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index bc2725491560..39642626a707 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -869,7 +869,7 @@ static inline int security_inode_killpriv(struct dentry *dentry)
>  
>  static inline int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
>  {
> -	return -EOPNOTSUPP;
> +	return cap_inode_getsecurity(inode, name, buffer, alloc);
>  }
>  
>  static inline int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
> 

-- 
James Morris
<jmorris@namei.org>

--1665246916-1261770800-1605842213=:20300--
