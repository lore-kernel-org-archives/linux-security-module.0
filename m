Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A98353EE0
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733579; cv=pass; b=O27aV+dNMNgWU3ydIkx+c+tayP2ZgsAXz4H9FQEs9zoiN++vaRb8XnAyZz4QF+tUoyt6EqI8s2zUEEfXKtqMg5n2KBmTxuUmf0qaOEoawhqcdYksgk253e0Sy1lDNCaI7E0uRWQhGYOxDV7G1T/JIFXAB+IqzDuCtd49buo61q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733579; c=relaxed/simple;
	bh=FXgNGZaCn31j4DBFtwd2epYk6bSzjHMX2Rpy2w/abkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCjzfR3ewywgxCZRN7/vr3QebXjstJ7R0FLA6n1GABOUQtHdn+9XPhFamtaFkIqMmIKlA3CAhQFprEvbBqJB7HtKFbAeCnUeYu2JKA0a7hIK0/39BO4Uk5VD06Df92sGn/R2Bd0gGcJE72AkhmMuaxmmtH78asq7j6WH8CP5SVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=X7eLh0g6; arc=pass smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="X7eLh0g6"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78d59bb02so1825799a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 29 Sep 2026 18:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790733577; cv=none;
        d=google.com; s=arc-20260327;
        b=MFWGqUlCCVB82mQAYmq3j/27m94Mn5+He0HXqijN/NvNMIx0MHiUBbnJBlxWzhxfhj
         8rVNnhv4mDLJ2Wu1c2/3OQ7atGZFZAcIXAk+V6HPsuY6jQp04JBtkL3hnn9ZBB0WOCeZ
         GnC6MXarcaVSU2U8t+oZjN6deSfPNUWNCRYE7G1jkc0LWcML+X+t43UdYMKAUgkNiNS2
         nW+GoWTEAsnNV4tnLqRUIV286bzlJ8mhRQjlQMiFbhKF+OP71pfRyihjk6SAE9Gi5nKL
         S+48Tie2wmlnOhvliLbPVvLFRUmHyAZbIIrDqGcSLpPPNNZ6VcRliBERr5TwBbl2OdS0
         KFyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PnKCgafJWQup5yHqx8hEqqKmbcy4exuf0d3rn3nhwcg=;
        fh=7mhoo6BZl5mwmRsTkIBnOsU22D3WT23N+1oZOjf8884=;
        b=Jxml/be+vfYB1t2rWRjIM+LpnQ/mibODirGJ91zKj6wDEVqKiveMm2Nw8x2Fj56iGG
         CMmPOIKbvexME94Z7bthuXXVyXHwhPv6DWVTjOuj3s9xNb7wWOhQsdTdIJGmpsp9iXCb
         i/j9udWwFV/oEobOcWWlyR8fnGE1L5AEdjVjrB/PQCQ0EClj0MSPIP/xqolLCxH6xN73
         xjQrZEraNL+T9FqHKImPLAMuUG8+UM9Ph5pZfw/caeFHk9N5Edk2OrxvI/AamJlHDXBH
         qy0DSeyb1eGjYXUKfB59Ou27PYsexQ56Qg1zyfiJv9OfcDiO+Kep78A5xNcV3Au+a4ni
         nlYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790733577; x=1791338377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PnKCgafJWQup5yHqx8hEqqKmbcy4exuf0d3rn3nhwcg=;
        b=X7eLh0g610HC9TjKiGsm7RAztKALAn1wRZMgcZNfwl/Wql3mNxk/P4cHH+h1LTgI/i
         yjXacBqSa+i30aa6P2+1EqWcsDjbmME+ocJqVniynfR3e0+PZdhPOosFnADxD1zgWFPo
         HOsQcCSIG7rGxAIMFlcOeBJHeIRfzPrACPtqXYqRWVEwp09vbL2Dc2bY5TwjFp2RrRKf
         OJ2CjUw6B1L2R10zIMeOTZZeD7sVQwzT4/DXOUZvVSyLcwH64wbmUU+tY1+5sg0Voza4
         cBldzefBKChfQzEHS2x1EmZqbO6HXedm6hvSvQ8JMTIfByS4O6S7rnssoha9LkUr/r3G
         XpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790733577; x=1791338377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PnKCgafJWQup5yHqx8hEqqKmbcy4exuf0d3rn3nhwcg=;
        b=pr4bXebxPSo6HJQoSqnVpam5Th6JfCZoFI268eHWTmntqS6oi41HgdxyDObdRUksjS
         ZNVlU8s65tSeTab83dt7fymisWHkWyPyb1j/c5+T9LovVJwHR1K96xG96bf830gUULN9
         5lGMWbyMALH9w6BJM8tYXjP7j0B0fTEv/Ztlg9+ZzCKcMFZ837W13DWWEef3+hFPY0Ea
         Z0GZJIXHJIRRD5n7eQNNB6MVgBERy0eZBnpwbr952rdpFrn+zjYLRmRD+5rXx9zDbm1f
         bO9iuZjkXPWnT4d74xtFlB7eMN9zV/KWrd2rsGEiTERTEgVFtioJCYyXNnoVe1lPhsl6
         rj/A==
X-Forwarded-Encrypted: i=1; AKwUvBwR1sV0AJtVDvcittAgaPnlK097oDj2Sb3vD+Q2vewBerUYIeihkI4O75PP6CC7S+ZDe72YA+nJUx36qo9XlXSErryXwEk=@vger.kernel.org
X-Gm-Message-State: AFuF++nX1W1mGJ5t1mH0lyud/5ADPz+/9yYdYz0e8Kon55HqjNQOEptg
	QHDBM8nImfZWd0gFUlztBEl8BMsXW0u07bLDS1Q79otRIdhCfAdAHxlx9oq0EtQDc0jX42Y3CGR
	Xg2SAIQ1Lsnedbue/4qOCwqDKgfASkLfzngeTojtrbiMyPZ0zmLKhaA==
X-Gm-Gg: AYBFou2pY8j0BFD3qCazNIAOhqmiKIcoyxNXpdk8Ffig1dNDAQ7TiUGSxt4FMmBIaJv
	oXuL5WJsjO5Hwrahb/QnGUot37c0GsrteOFvFLYl/JMesGbkY8mHGkWAfXkPK4vkuZ/Apu1/oar
	S19w8qy4E82lE0LeNOx3y4U5MZ02gBn9NYdiQR2N0i+pz6QG/VMHI16/WNPsuMjF7HLSPxTr6gw
	B5nd7ZRXwHgM5+ijHEmv+hVkD5ZSsrNyq3sL4rFJ2CWZqTWv2uFDR6pISF0dcHvMcRuwnrwM6zV
	62sXtZ/GHar7iHcSDNe81DOQDSeNzIr5a+b2IqhzzWaUr42j/uD6qJnZNwVXyWdMIzYYSBlojwg
	sIwEvPPgE54w=
X-Received: by 2002:a05:6300:220d:b0:3cd:9f99:3381 with SMTP id
 adf61e73a8af0-3de94905417mr1019217637.0.1790733577321; Tue, 29 Sep 2026
 18:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918143142.19435-2-stephen.smalley.work@gmail.com> <20260925-gebaggert-ersehen-serpentinen-a6e61570e1b7@brauner>
In-Reply-To: <20260925-gebaggert-ersehen-serpentinen-a6e61570e1b7@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 Sep 2026 21:59:25 -0400
X-Gm-Features: AclHuK_v-UBDTipntnTunBskRxQtvMO6S21KmUc_dfH5j9vuCr9SBVNXz7dBt-U
Message-ID: <CAHC9VhTga1k7SnT+JXWgmCdfsEDkm83PwjonVBpNeNm+q3UWVA@mail.gmail.com>
Subject: Re: [PATCH v3] lsm,nscommon: initialize the security blob for the
 initial namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	mic@digikod.net, serge@hallyn.com, jack@suse.cz, jmorris@namei.org, 
	omosnacek@gmail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 9:58=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Fri, Sep 18, 2026 at 10:31:43AM -0400, Stephen Smalley wrote:
> > Commit f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > added a security blob to struct ns_common and allocates it from
> > __ns_common_init(). Most initial namespaces (init_user_ns,
> > init_uts_ns, init_pid_ns, init_mnt_ns, and, depending on
> > configuration, init_ipc_ns, init_cgroup_ns and init_time_ns) are
> > however set up statically via NS_COMMON_INIT() and never pass through
> > __ns_common_init(), so their ns_security pointer is left NULL for the
> > lifetime of the system. Any LSM that registers an lbs_ns blob and
> > dereferences its slice on one of those namespaces (for example from
> > the namespace_install hook when a task setns()'s back into an initial
> > namespace) will fault.
> >
> > Allocate the blob and run the namespace_init hook for each of these
> > namespaces at the end of security_init(), after all ordered LSMs have
> > registered their hooks, so every LSM sees the initial namespaces the
> > same way it sees init_net (which is initialized at runtime via
> > ns_common_init(&init_net) from net_ns_init() immediately after
> > security_init()) and does not need to special-case them in its own
> > ->init() callback.
> >
> > Provide a ns_common_init_security() helper in kernel/nscommon.c so
> > that the list of statically-defined initial namespaces and their
> > Kconfig guards live next to the rest of the ns_common
> > infrastructure. init_net is intentionally excluded: pre-initializing
> > it here would leak once __ns_common_init() clears ns_security and
> > re-allocates.
> >
> > Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
>
> Seems good to me,
> Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
>
> I'm waiting for Paul and then I would pick this into namespace-7.4.misc.

Since we already have the other LSM/namespace patches in lsm/dev I'd
prefer to merge this patch into lsm/dev so it is we have the core
LSM/namespace patches rooted in one branch.  Going forward we can
stick with the topic branch approach.

Are we all okay with that for this patch?

--=20
paul-moore.com
