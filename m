Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978373;
	b=klHAmQ5q8QnbYcIyQPnNQI88639BtDwR6y3ednHPdV2NchljWoPmgFAFLzhbJ1SQ3ruS
	 p97md7jQx9SSCUur8EtpCQUsK1/g7HDkYrXugSIvcqtVxptN8GIUhMW/Fy4/GHJt/TRT5
	 pvLYn63uJ5lL2U9VCeRienKDxzKNBOX3rG8RiMdO2IEnI328BrmEw0YiG7Xiyxi+Go4T8
	 rZ0hNQBqKjjkah8jgPy1gzPZ5wNSP3ThXEvxUaNYn4U6BqgObay2LDbbmHdMYYRXtSX1A
	 e9kto8mRjY0YSW/w7dAyhCKqJGEv4vLkKkLjOe3kG7BjZUtbz4/2qo9y/7eHXXR2TEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978373;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=L6QE5LUaMLGNUcgDxlWZZglb/NRd2D5dLMiLzKGOWzQ=;
	b=ONPY/kfv3hAVk1QfSi22uwPcmwawyVX88KhOfWg6q9FZlQWJFnBOvAOWfcTLKWzMfPI9
	 Jv901DcplHC5XMLqw1nXwNVMoV2GGxpHgoBVwTp6maRHu0OUtzh0GjREdMai1rHFQVAbA
	 lpmo8pAP4cDimFm+xdpec4pvjURpWGVzStVlpJeRCncq5WMAtJHHdr8iMhmKDuWpKdFnh
	 i4dIGC4Y16/59avxtm3PhcvOw5sDMVOFULxW5HxNsp/E4hhMWzMg/e6VgYTRiveCrH5s2
	 0xbXkrhOSAdVsvEvJAC3NMrUZBE5PPE9X2qcurBnsR3QhTjZon/nyFK4g7XhR7AMtUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EmCeU1t+;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D9606A32E
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 15:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D79D9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EmCeU1t+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793978372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6QE5LUaMLGNUcgDxlWZZglb/NRd2D5dLMiLzKGOWzQ=;
	b=EmCeU1t+M0YqRjsNu5pfyyjZvjtq8tkcJNNky58y6x0C5NNX96Th+qerXV/5BB7BLVY9qa
	4G97VL0DKHs7RmHmrSsUlkk2E0zeGzQ6WkT2RgDiEvPrMBX8OWkBFG6xKRCFXUJjCmw3Ep
	RboB+jqcLMEjSAm6pillE61UT33DNRI=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-xMy6SQ5hMhuncvSsQ4mB_g-1; Fri, 06 Nov 2026 10:19:28 -0500
X-MC-Unique: xMy6SQ5hMhuncvSsQ4mB_g-1
X-Mimecast-MFC-AGG-ID: xMy6SQ5hMhuncvSsQ4mB_g_1793978368
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4b26d8d2498so866770b6e.2
        for <linux-security-module@vger.kernel.org>; Fri, 06 Nov 2026 07:19:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978368; x=1794583168;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L6QE5LUaMLGNUcgDxlWZZglb/NRd2D5dLMiLzKGOWzQ=;
        b=0XoExXt3i1TQgbdLinuqrUM5FYG4v+zLakj18UUSttDRapv3/dJTZFmqyWeDJgmEWr
         LCL8R1Y2mkos39n7BCIQpMkBvbuxqTg+2ouULGrX4Pdxb6xQGnu7FQNFjzHbYcfltIBC
         wzYJzdZCzveYk9z+uQL3LuiO0LuSVrEchgZn/eQac+RlXrnayHryZipvIZ9z7HtORpNB
         eqtBtcwFKX4KqJVXzBEtglPR/UA+ls9NVEH9CknghxXaDIB5G6LhiFBGWEgpNbiSZN0x
         jeQot2t2fwkBnB+IxfDbVKbg3RhBIq82HkbefMAAMxTSgtqKso/EzNndNoLVXITajLyU
         7NKA==
X-Forwarded-Encrypted: i=1; AKwUvByXiTPt2XZjnYMcM2yyiFRRrBUt4fPYBESoBIBMdWN6sah34VQ4beeP76Axpkl33z57nq5pDOtmMnyWQmD54FoM5PI1iSg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8IRffOQl/Z3BQjGaNqmAzq+5jLIC3JYbnMUiYVpsgu2E78qBNo
	OkkXfabHyA6pBa23XT7EDXo5tl4+YCeyPy4zYzZiGWO2nkCKUsRV3kc0djgk/wBofKHdqSMhftn
	P3qkoWhYG6Gh9O4VYyHGN7WMo7hyzNDgKIXfbcpMnduOn69lun+NWp+d6Dhx7pARK6HsIJ5Zrwj
	CFID8FW0FwFKmrruK1Wh33hfWdoKJElSNHxB4VC5HZx8G6fjdz29+D
X-Gm-Gg: AYBFou0SwyRI0r8E/hYA5klZ+1TWi9F5u/kvAxQExuB1Lp2nHhKvZgml5Fzeu7ht0PQ
	C9oIeiURef8fW/WFRoyK9kXM8GJ2aPTpLB1FtPKEQVOgd9X1+JYhWZYpwfJOU9yvjaWZ9Qp4j1l
	7dn6BJ2NNh+gly37ttSYvii0mQhADBUDO1qt4k74i/n27Ni39yUcdMJIsW
X-Received: by 2002:a05:6808:6413:b0:4e9:3412:14ac with SMTP id 5614622812f47-567e10ac541mr2034255b6e.33.1793978367832;
        Fri, 06 Nov 2026 07:19:27 -0800 (PST)
X-Received: by 2002:a05:6808:6413:b0:4e9:3412:14ac with SMTP id
 5614622812f47-567e10ac541mr2034200b6e.33.1793978367246; Fri, 06 Nov 2026
 07:19:27 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-6-1819a017000b@redhat.com> <sashiko-outbox-198921@kernel.org>
In-Reply-To: <sashiko-outbox-198921@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 6 Nov 2026 16:19:15 +0100
X-Gm-Features: AclHuK_9kd4-vi33h14qEUizW5VOTBDWrh0Qg0FV14Te6uxs8q7OXuaFrYepPH8
Message-ID: <CADSE00LW0+EwEg8OBXUzZSkAu1-X=ofX5Dirq0+gbTTBUho6_w@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] selinux: Restrict cross-cgroup dma-buf charging
To: sashiko-reviews@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, media-ci@linuxtv.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CrKmZE7kUrJj-4Ooopi56GLa3zBiJyajt_PsECGTuMY_1793978368
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 12:12=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] selinux: one-off dma_buf class instead of general cgroup acces=
s control model
> --
>
> commit 675e985fff50ea6716b8c00023a75c07ff345a6f
> Author: Albert Esteve <aesteve@redhat.com>
>
> selinux: Restrict cross-cgroup dma-buf charging
>
> This commit implements the selinux_dma_buf_charge_task() hook and adds a
> new dma_buf object class with a charge_task permission in SELinux to
> restrict cross-cgroup dma-buf memory charging.
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 30776b0107f29..8f39d91eabc97 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2204,6 +2204,12 @@ static int selinux_capable(const struct cred *cr=
ed, struct user_namespace *ns,
> >       return cred_has_capability(cred, cap, opts, ns =3D=3D &init_user_=
ns);
> >  }
> >
> > +static int selinux_dma_buf_charge_task(const struct cred *from, const =
struct cred *to)
> > +{
> > +     return avc_has_perm(cred_sid(from), cred_sid(to),
> > +                         SECCLASS_DMA_BUF, DMA_BUF__CHARGE_TASK, NULL)=
;
> > +}
> > +
> >  static int selinux_quotactl(int cmds, int type, int id, const struct s=
uper_block *sb)
> >  {
> >       const struct cred *cred =3D current_cred();
>
> [ ... ]
>
> > diff --git a/security/selinux/include/classmap.h b/security/selinux/inc=
lude/classmap.h
> > index 90cb61b164256..b4ebedc6e4240 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -181,6 +181,7 @@ const struct security_class_mapping secclass_map[] =
=3D {
> >       { "user_namespace", { "create", NULL } },
> >       { "memfd_file",
> >         { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } }=
,
> > +     { "dma_buf", { "charge_task", NULL } },
>
> [Severity: Medium]
> As reported by Paul Moore on RFC [1], adding a one-off SELinux object cla=
ss
> and permission for a specific subsystem's cgroup charging (previously
> dma_heap with charge_to, now dma_buf with charge_task in secclass_map[]
> and selinux_dma_buf_charge_task(), along with charge_cgroup in a later
> patch in this series) introduces a narrow, subsystem-specific policy clas=
s
> rather than a general cgroup and resource access control model for SELinu=
x.
>
> Although resolving the target memcg from charge_fd moved into generic
> memcontrol code in mem_cgroup_get_from_fd(), the SELinux hook in
> selinux_dma_buf_charge_task() and class definition in secclass_map[] stil=
l
> define a dma-buf-specific class instead of a broader cgroup access contro=
l
> abstraction.
>
> Should this permission check be designed around a general cgroup or resou=
rce
> SELinux object class rather than a one-off dma_buf class?
>
> [1] https://lore.kernel.org/r/16093a0278a6d7d1a0a8bc055c228bed@paul-moore=
.com

I held off on this so the core charging proposal could settle first,
and then refine the LSM side later / in a separate series depending on
the feedback.

For v5 I'm adding a capability baseline in mem_cgroup_get_from_fd()
following a Sashiko report, so that charging a memcg outside the
caller's own subtree requires CAP_SYS_RESOURCE. With that in place the
LSM hooks no longer act as the only check, they add finer-grained
policy on top of it. Also, unlike the RFC, they are now called from
generic memcg code rather than dma-buf code, so I should have renamed
them (and plan to) to security_memcg_charge_{task,cgroup}().

Regarding the broader cgroup model, as far as I can tell, existing
cgroup control points are kernfs file operations, which SELinux
already covers. The only non-file operations taking a cgroup fd (i.e.,
BPF attach and perf cgroup events) use their own subsystem classes.
Since remote charging in this series consumes the target cgroup's
resources, checking against the cgroup's label (as patch 7 already
does) sounds like a good fit.

So to Sashiko remark and Paul's comment, rather than a dma-buf
specific class, would something like a "cgroup" class with a
"charge_to" permission for the cgroupfd path, and a process (process2
really) permission for the pidfd path, be an acceptable first step,
with the class growing as other non-file control points come up? I'm
happy to adjust the naming or structure to what works best.

BR,
Albert




>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-v2_20230=
123_tjmercier_google_com-v4-0-1819a017000b@redhat.com?part=3D6
>

