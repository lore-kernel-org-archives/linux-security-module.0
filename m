Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0335431717D
	for <linux-security-module@vger.kernel.org>; Wed, 15 Jul 2026 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148101; cv=pass; b=YoD4OHKJw8gw8Zjl4PTWt0HZK62eZZEQryssLJGeczAsFSqzOK3GZS7MnXXD69qEd8naToVfZMLafX/fh0JzutCrVBu8Uud0FXm12cxi/+xUIb+JLbu+5bjpBZbUAgRAMWNZOnie1rgllga00TDgkAnPXMnWPtWuNkt4cnJmQUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148101; c=relaxed/simple;
	bh=WFUZsI+9mzM5h3Hu8cIqgWqx4bsjN+2caS2Ww8w777g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYvoytUTz/d+ldIQYfLJ0iFTf/XPtP1XljfvdiqKnEGqugTc6y3yTl9HwAmx2Bk5K0uFG70vtzwvdgwRIsLLMtbN3H18UyfEccMWB5HkUt3XPL479AHtSKRA0M+Afa2h3UKwah7QSdraBymU0OeFDAyaN4gy66diuNsWa4P6fw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fQL2VAxn; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fQL2VAxn"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso2838356a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 15 Jul 2026 13:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784148099; cv=none;
        d=google.com; s=arc-20260327;
        b=XGlhUhh+2kggCVC/jiy8AtQ2WuMpYgZQlYTdQMpvt9lQeOzDXz+Jjj765QrVbeLjqm
         CocHxgtjommkTj0Xba7u9JkW08YzmJNDTmP7AFL5x8z8Q8Td9F+XKHV3Ay73+3xOf30l
         tdEmZFQbhgNeGNP/bSv7T50Y9/2r7bHDvCj4Ijd3Krjdy8E+Kgv6af8rRo83cKdR+vNl
         /lv33K6CXJLhQNVM1u1YkEAMMx9z/gtvBAaBGyfIO9g5cxQSlyDfl3W50p3PCm+6qjvS
         TMU1SswT4XUtXnsU+CKf7rFjdMzYvoCV+eOW8EsnCAtpzT/rDw493XPNzoNDihMR3UoU
         B3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y4+6tUBvv9kkZdWXGDMO01Jh6FEAjGQaTiyDDZ/AJ9A=;
        fh=SOMDWRiktmjwPcFhn3ob6bhh/AcD+XHTQYSoVPvOrd4=;
        b=a5fO00ONVD+GSkMmTiqYGJ0/gjig/TiO73YvCVOHOeCOqorke3pqbPborxvHqQWoGn
         WBddR/XVdqzzcphWaskMI8OpGnMmc4/+sq63QApUQ1oYzWOHWOT5/p8U7eF/I/+qlGd9
         j5wrs8dabcBFL+uqNmoNrrOFmKYiR33jJq8UjMkCexf16qtLV7tu1iKth8wWonSt8NDt
         gLoAKdwps0UOsWMaY5k7TH32Ffe0eUa7E5murbc/M+2Jcq9L9QNmG4k0MjD/kJtKoX+v
         stU+6j0S/+swmbN1QegkdESupNShL/ZIqC61SGKp2IAuT7k/1dlFR21UD3+2Z87mwh7c
         KRsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784148099; x=1784752899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y4+6tUBvv9kkZdWXGDMO01Jh6FEAjGQaTiyDDZ/AJ9A=;
        b=fQL2VAxnymU623YvOy/fm+gzOXjRmvV+oJOQ0q5D/1I0oITkZ8+rA7YjnvgQ32R2Gl
         Uzyh7mdGOKFDRt6GLMCT5awLnQTHPZm84tF0ZEz7BBIXHpekePgePIMNp4OVmvmfCwoi
         WdhK3nie2/FdH1+gFnk18zWkPXqb+FVJEyo0umeDv7OKfHMEKDuCbIj9j1i6S6AJiNCq
         Vhbiliy6g/iu/VMAntEyh69tHYdPTSPcsEhSDNUAImr6ERExNXSIPBYu8TPTOhfInp2W
         XdsSB4V0ve+1GZ900/ZOMk07MuWQ8MUM30Koxn+8XdLq++ubDgs7USBktF9IXDikSqUb
         xMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784148099; x=1784752899;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y4+6tUBvv9kkZdWXGDMO01Jh6FEAjGQaTiyDDZ/AJ9A=;
        b=jk7ZKRylc5EHW0lUlk2T7SgVwdqLNLv052dVYWFJfaeJX7pHyMJO/nWLWr3TXMhgcq
         1rhpC34lnQk19o3s8zznVlPVUmKAzzpqFfjw+o8b2zy/2yO6ufKSDis9gwJPdJQjnc/7
         5Nf6O5AKrx/02kAXQIFnUBD6kAToOQtobF6PzTphE1Kx4mJScME0nsD3fTob3ua69S7+
         qHeIzCWeCmF3ozHc03iAMYw7lYT6KLQJlU4GtiCxim2lo0sGG4se/rhsP+LXJ0qikZwG
         fTJClNHEBSdnJXsIFKb59toBY5i1BfsqaC0+ef3OoPW5dgClmr97CxgEJMqo4g/R10v3
         TTDQ==
X-Forwarded-Encrypted: i=1; AHgh+RohfKs5ErD9TKdvP37nGweVQBSeKzjbS79awtw9T87XPQIG/iNVKy7A4YhZPqrcK5kZNe1Bo+y/01I13oZ4iisfR3fXC2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/lC2BXPuXIHvS/WLRJVVGEGP1Zna24qexKsMB9E6lKXdmxeSG
	53s+bUqphsy1FvlUSg7Gfupu/X1Va9+MkRkrE/CccIQPJSoLtUm6+z0L03HEVMDSVmXu9023h7A
	/wvj7J0NjbyiFDb7GFpmLf2Z9OXYzxp2y5+TD49HL
X-Gm-Gg: AfdE7cmiW+XPNv3XjzF5LsKszGaShut2gDtx5VswFnZckgKbHzdV2DBfQOUM49XmD+7
	FNXeNYlMo1oVjPtgZsqtVVuD2chzf/NX9EDaLKN9x46tL6HazJ+6G/2dHnMiAjlx3e3osE2HC7W
	rFLyFH+ehCHUGz9/DpR3eWnM6LbmpYZDkZHj3TO6TCZXQGWWuf4/iWFi6w0X2CJ1M4KtNiOvvbV
	F8ZSyQBg7xStzle9HK7y88A7mKm9HVQCXoD8fGZquwI0E5sMlNSlXZPbraW6pGoVx26nfoF
X-Received: by 2002:a17:90b:1646:b0:38d:c834:24cf with SMTP id
 98e67ed59e1d1-38e2a01d044mr3677818a91.23.1784148099381; Wed, 15 Jul 2026
 13:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
 <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com> <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
 <CAEjxPJ7dttPDxQDa_xXFd1H-QT_vkUwjtnH+=3cmG5dhSiaAXw@mail.gmail.com>
 <CAHC9VhSyCuiPBRWz_vUbx7+L5yLiXkjKX+7UyCLr82-_gAj2NQ@mail.gmail.com>
 <CAEjxPJ4+wgUDY3YxajZ=2D3WLzgat_Mqvr05VtJ4KrXW7_kuXA@mail.gmail.com>
 <CAHC9VhSxpAx+G35fbcMjJ1PfqJxDZYpTEu=qpO+0PQe=nkX5-g@mail.gmail.com>
 <CAHC9VhRq+Vth-4D4OHFAY_6hXqmj=MgTc_2G=3Ehr6bAQzp26Q@mail.gmail.com>
 <CAHC9VhQy4LOgQg0mk+s5sjHOzMe1sxPUgJ2W7vRT8ms4znZp+Q@mail.gmail.com>
 <CAHC9VhR+pWFnt=1pBJTky78br7NsfVcZE=V4UkfkfTbMvBo+mQ@mail.gmail.com> <alaxhbWbFMZyC8VQ@smayhew-thinkpadp1gen4i.remote.csb>
In-Reply-To: <alaxhbWbFMZyC8VQ@smayhew-thinkpadp1gen4i.remote.csb>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 15 Jul 2026 16:41:27 -0400
X-Gm-Features: AUfX_mzsfoszHbfyg2O-Br4gvumLi1bZDkqDuMmCQGdfP1UYUVx-vIZEGp6Qv2I
Message-ID: <CAHC9VhTAa7_tsWOuYELMnC+Zm2gW8PRT3sWvoN7Y=m5Q3UJBUQ@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
To: Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>, jlayton@kernel.org, 
	chuck.lever@oracle.com, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Achilles Gaikwad <achillesgaikwad@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 6:00=E2=80=AFPM Scott Mayhew <smayhew@redhat.com> w=
rote:
> On Tue, 14 Jul 2026, Paul Moore wrote:
> > On Fri, Jul 10, 2026 at 6:20=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > ... and scratch that, the offending commit was that one.
> > >
> > >    commit 01c2305795a3b6b164df48e72b12022a68fd60c1
> > >    Author: Jeff Layton <jlayton@kernel.org>
> > >    Date:   Wed Mar 25 10:40:32 2026 -0400
> > >
> > >    nfsd: add netlink upcall for the nfsd.fh cache
> > >
> > >    Add netlink-based cache upcall support for the expkey (nfsd.fh) ca=
che,
> > >    following the same pattern as the existing svc_export netlink supp=
ort.
> > >
> > >    Add expkey to the cache-type enum, a new expkey attribute-set with
> > >    client, fsidtype, fsid, negative, expiry, and path fields, and the
> > >    expkey-get-reqs / expkey-set-reqs operations to the nfsd YAML spec
> > >    and generated headers.
> > >
> > >    Implement nfsd_nl_expkey_get_reqs_dumpit() which snapshots pending
> > >    expkey cache requests and sends each entry's seqno, client name,
> > >    fsidtype, and fsid over netlink.
> > >
> > >    Implement nfsd_nl_expkey_set_reqs_doit() which parses expkey cache
> > >    responses from userspace (client, fsidtype, fsid, expiry, and path
> > >    or negative flag) and updates the cache via svc_expkey_lookup() /
> > >    svc_expkey_update().
> > >
> > >    Wire up the expkey_notify() callback in svc_expkey_cache_template
> > >    so cache misses trigger NFSD_CMD_CACHE_NOTIFY multicast events wit=
h
> > >    NFSD_CACHE_TYPE_EXPKEY.
> > >
> > >    Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > >    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >
> > Playing around with it some this morning on a current Fedora Rawhide
> > system, I can reproduce the problem with a simple command line:
> >
> >  %  mount -t nfs localhost:/mnt/test /mnt/nfs_test
> >  mount.nfs: Connection refused for localhost:/mnt/test on /mnt/nfs_test
> >
> > ... adding an explicit "vers=3D{4,4.1,4.2}" has no effect; versions 2
> > and 3 are no supported on my kernel builds.  There is nothing obvious
> > in dmesg.  I've run with SELinux both in permissive mode and disabled
> > and encountered the same problem.  This doesn't appear to be related
> > to SELinux, it may simply be that we are the first ones to hit this.
> >
> > As there was some earlier discussion about this being a wonky
> > interaction with userspace, here are some of the relevant packages on
> > my system:
> >
> > nfs-common-utils-2.9.1-4.rc4.fc45.x86_64
> > nfs-client-utils-2.9.1-4.rc4.fc45.x86_64
> > nfsv4-client-utils-2.9.1-4.rc4.fc45.x86_64
> > nfs-utils-2.9.1-4.rc4.fc45.x86_64
> >
> > My next step is to try disabling portions of the NFS file handle cache
> > upcall to see if that is the issue, but it would be nice if the NFS
> > devs could take a look at this too.  I'm happy to test things out or
> > answer any questions about my test system.
>
> Pardon the dumb question, but are you positive your NFS server is
> running?

I'm slightly embarrassed to admit that your question wasn't as dumb as
one might have thought :)

While my bisection testing used the selinux-testsuite which ensures
the NFS server starts, when I tried to create a simple reproducer to
share with the non-SELinux crowd I neglected to verify that the NFS
server was running, the directory, was exported, etc.  My apologies
for the confusion.  However, the problem was real, even if my
reproducer and error message were junk.

> FWIW the netlink upcall requires CAP_NET_ADMIN, which is blocked by the
> current selinux-policy on rawhide (and I think it's a dontaudit rule)...

As a quick test I added a quick hack to my policy (allow rule below)
and everything appears to be working again.  Thanks for the pointer!

 allow nfsd_t nfsd_t:capability { net_admin };

--=20
paul-moore.com
