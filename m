Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E31C3F19
	for <linux-security-module@vger.kernel.org>; Tue, 27 Aug 2024 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771315; cv=none; b=Az3FBf+jfKwM27dVDpgkxCDsFTgxk2VUP/rl/RSVB+LzZ53KH2fqyHuRR4pJYYwoX/bzhzQu/FzHaUxbng+DLTq1yOgIYxr12hRU0KMgklzXdKGSl9YpiEZpF6xdBq9iOvCSk2GtVj3BpZzBZ1vRd3yRLoG8+PO/Lt1gC17PBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771315; c=relaxed/simple;
	bh=wcV0zV6VazbjOKL6E4PWIqqIZADqEUvdtVT4mtA2lp8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AZqFhz0q3LRH+zqmNsXuo8uaOIXctx4rSwGIuxigx4Q8A6R12FsgMGSFHSkvHj4hIFO2AVuMjuMZZbOQW6xvWbeo9jsKguMntsf3cz2H1+95dIRh2Gr+jMpDWksXVxAQGq40GgPnjKL9WivzX9nYrglfUNsn3aGx4IB8yojAHWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ousbzO2U; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ousbzO2U"
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 316693F6B9
	for <linux-security-module@vger.kernel.org>; Tue, 27 Aug 2024 15:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724771311;
	bh=2HRLF9mhfqSozw/W7Ek8yQVE7MsvHVUb3zolIkNBqZc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version;
	b=ousbzO2UpW1yGP8xLPbmVvgp/82xWusU30zwru37xC5guEGyDkg7Q2fa1oTVHm+/J
	 zQa50pxntyHBQgcVH7gf057quM1wrKKzu9GRfymfOIPKL9TfHJskFkh87+I0TwxpD3
	 Qhvds5yb2X4mPf/k0FECmDrSjn1DbX6lRpiSpkkRYfEAKtebto8TDB7pGo1kopnvSP
	 wTdXOli+/HBJeJzQHkwhbo+U5tA4LxKrYCghia42/wKQ2BCyZsmNX/wCbVDXHzhLef
	 3oWkFmwXkWMb6Cza8vX7SmECG5HF7lMZai+BsS1MEPnfZQVKD5JdH080uS3ob+s1Lk
	 rskaLeA8dTbrw==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d45935fed4so7266935a91.3
        for <linux-security-module@vger.kernel.org>; Tue, 27 Aug 2024 08:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724771310; x=1725376110;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HRLF9mhfqSozw/W7Ek8yQVE7MsvHVUb3zolIkNBqZc=;
        b=GXAJfr9VTW0MC+fjPNGFDXBWyJLy6fHh/MsrS0sfue+Rwh0N69QDXypnwGNbYZ6z+X
         n2rlR+Pu7uC7OM9wjW8B25CvKlXBzXwiooFQSteu0cvg9TlNDdvfTl7ta83/a7udN42G
         TKwr2ol8+ZNJr8K3ury9e5M6Gwn56J7oVCDOpGJ9POahQogMBaHZbatWx+l4DPd0ABhz
         CdtB1ZzIB15trhkmaMdHkdcoo+rQur42ltnW00RKwuW53sX1CH0Xl+ZcXWrF2PSVY85X
         CCOpCp81DoIF2JccXhwzM2pxcShBV7QUM9HbBYD+WIfrBH6ua99uluudNcz5yVH+vvj5
         B82A==
X-Forwarded-Encrypted: i=1; AJvYcCWpifStOsFriFwzgWu6/TC9UJ3g+CsPPEjt8yoBcs50Vh8RXI95MTl6G/N9j+HT2jywpkAgxEGcbb0IeVSU/yceYxkHt4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YymB9p4n8DIaedZyZI6Fi0VkVohOUsUUtVg0TcPnkkqtTMJSTTr
	HXXg+TpHrJbZYiOfBWkZytS1JIFvVPntwXsJksT5J/WaOweFl+7opBhfuypkmmaBP4wvvxu+8Uo
	G0o24EgguXoSWhLQ7Bsm980KvHxgp1n1f7tp2Yi/ushKTJ1EkIzx4cGF2u374c32v2trMlOWXJx
	SuuGDxB9UFaCQ1wA==
X-Received: by 2002:a17:90a:5e01:b0:2c9:7aa6:e15d with SMTP id 98e67ed59e1d1-2d646c26ccfmr13728479a91.20.1724771309733;
        Tue, 27 Aug 2024 08:08:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSeQR3bVBwiGnjQtNSUz5tGUexHWkG/wNu8i+jJ2qrakYsJ/2kCGWTQtYbQWRb/zwz7IvPhg==
X-Received: by 2002:a17:90a:5e01:b0:2c9:7aa6:e15d with SMTP id 98e67ed59e1d1-2d646c26ccfmr13728445a91.20.1724771309267;
        Tue, 27 Aug 2024 08:08:29 -0700 (PDT)
Received: from ?IPv6:2001:1284:f502:1ed0:3614:22f:7b0b:19c1? ([2001:1284:f502:1ed0:3614:22f:7b0b:19c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613941ee7sm12286853a91.24.2024.08.27.08.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:08:28 -0700 (PDT)
Message-ID: <e0fc63dea4db21f53dd3358334029aae3981fc5f.camel@canonical.com>
Subject: Re: [PATCH 04/13] Audit: maintain an lsmblob in audit_context
From: Georgia Garcia <georgia.garcia@canonical.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com, 
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 mic@digikod.net
Date: Tue, 27 Aug 2024 12:08:23 -0300
In-Reply-To: <a8aeacdc4afec5855fa4b80f0f5f43e8f7d3b5cb.camel@canonical.com>
References: <20240825190048.13289-1-casey@schaufler-ca.com>
	 <20240825190048.13289-5-casey@schaufler-ca.com>
	 <a8aeacdc4afec5855fa4b80f0f5f43e8f7d3b5cb.camel@canonical.com>
Organization: Canonical
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 12:01 -0300, Georgia Garcia wrote:
> On Sun, 2024-08-25 at 12:00 -0700, Casey Schaufler wrote:
> > Replace the secid value stored in struct audit_context with a struct
> > lsmblob. Change the code that uses this value to accommodate the
> > change. security_audit_rule_match() expects a lsmblob, so existing
> > scaffolding can be removed. A call to security_secid_to_secctx()
> > is changed to security_lsmblob_to_secctx().  The call to
> > security_ipc_getsecid() is scaffolded.
> >=20
> > A new function lsmblob_is_set() is introduced to identify whether
> > an lsmblob contains a non-zero value.
> >=20
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> >  include/linux/security.h | 13 +++++++++++++
> >  kernel/audit.h           |  3 ++-
> >  kernel/auditsc.c         | 19 ++++++++-----------
> >  3 files changed, 23 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 457fafc32fb0..a0b23b6e8734 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -277,6 +277,19 @@ static inline const char *kernel_load_data_id_str(=
enum kernel_load_data_id id)
> >  	return kernel_load_data_str[id];
> >  }
> > =20
> > +/**
> > + * lsmblob_is_set - report if there is a value in the lsmblob
> > + * @blob: Pointer to the exported LSM data
> > + *
> > + * Returns true if there is a value set, false otherwise
> > + */
> > +static inline bool lsmblob_is_set(struct lsmblob *blob)
> > +{
> > +	const struct lsmblob empty =3D {};
> > +
> > +	return !!memcmp(blob, &empty, sizeof(*blob));
> > +}
> > +
> >  #ifdef CONFIG_SECURITY
> > =20
> >  int call_blocking_lsm_notifier(enum lsm_event event, void *data);
> > diff --git a/kernel/audit.h b/kernel/audit.h
> > index a60d2840559e..b1f2de4d4f1e 100644
> > --- a/kernel/audit.h
> > +++ b/kernel/audit.h
> > @@ -11,6 +11,7 @@
> > =20
> >  #include <linux/fs.h>
> >  #include <linux/audit.h>
> > +#include <linux/security.h>
> >  #include <linux/skbuff.h>
> >  #include <uapi/linux/mqueue.h>
> >  #include <linux/tty.h>
> > @@ -160,7 +161,7 @@ struct audit_context {
> >  			kuid_t			uid;
> >  			kgid_t			gid;
> >  			umode_t			mode;
> > -			u32			osid;
> > +			struct lsmblob		oblob;
> >  			int			has_perm;
> >  			uid_t			perm_uid;
> >  			gid_t			perm_gid;
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 23adb15cae43..84f6e9356b8f 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -724,9 +724,7 @@ static int audit_filter_rules(struct task_struct *t=
sk,
> >  				/* Find ipc objects that match */
> >  				if (!ctx || ctx->type !=3D AUDIT_IPC)
> >  					break;
> > -				/* scaffolding */
> > -				blob.scaffold.secid =3D ctx->ipc.osid;
> > -				if (security_audit_rule_match(&blob,
> > +				if (security_audit_rule_match(&ctx->ipc.oblob,
> >  							      f->type, f->op,
> >  							      f->lsm_rule))
> >  					++result;
> > @@ -1394,19 +1392,17 @@ static void show_special(struct audit_context *=
context, int *call_panic)
> >  			audit_log_format(ab, " a%d=3D%lx", i,
> >  				context->socketcall.args[i]);
> >  		break; }
> > -	case AUDIT_IPC: {
> > -		u32 osid =3D context->ipc.osid;
> > -
> > +	case AUDIT_IPC:
> >  		audit_log_format(ab, "ouid=3D%u ogid=3D%u mode=3D%#ho",
> >  				 from_kuid(&init_user_ns, context->ipc.uid),
> >  				 from_kgid(&init_user_ns, context->ipc.gid),
> >  				 context->ipc.mode);
> > -		if (osid) {
> > +		if (lsmblob_is_set(&context->ipc.oblob)) {
> >  			char *ctx =3D NULL;
> >  			u32 len;
> > =20
> > -			if (security_secid_to_secctx(osid, &ctx, &len)) {
> > -				audit_log_format(ab, " osid=3D%u", osid);
> > +			if (security_lsmblob_to_secctx(&context->ipc.oblob,
> > +						       &ctx, &len)) {
>=20
> Is there any reason to stop auditing secid when we fail to get the
> security context?

Well, yes, if we're moving away from using secid for all LSMs, then it
doesn't make sense to audit it here anymore, so nevermind :)

>=20
> >  				*call_panic =3D 1;
> >  			} else {
> >  				audit_log_format(ab, " obj=3D%s", ctx);
> > @@ -1426,7 +1422,7 @@ static void show_special(struct audit_context *co=
ntext, int *call_panic)
> >  				context->ipc.perm_gid,
> >  				context->ipc.perm_mode);
> >  		}
> > -		break; }
> > +		break;
> >  	case AUDIT_MQ_OPEN:
> >  		audit_log_format(ab,
> >  			"oflag=3D0x%x mode=3D%#ho mq_flags=3D0x%lx mq_maxmsg=3D%ld "
> > @@ -2642,7 +2638,8 @@ void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
> >  	context->ipc.gid =3D ipcp->gid;
> >  	context->ipc.mode =3D ipcp->mode;
> >  	context->ipc.has_perm =3D 0;
> > -	security_ipc_getsecid(ipcp, &context->ipc.osid);
> > +	/* scaffolding */
> > +	security_ipc_getsecid(ipcp, &context->ipc.oblob.scaffold.secid);
> >  	context->type =3D AUDIT_IPC;
> >  }
> > =20
>=20

