Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA107517BA2
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914213; cv=none; b=aswMardH5eJyQtq1mHCCRlN5/Hr3J3uFllcs9VAjBZZdaROwOYUnnEPLQ3PVYperNQnNXO0TjJ3ttSxDMx2ih1vkC8jSoAGUWgttnZccxfL09LJ9bx1nNwm1FGgnZk+GziiTSLcl/M9c3MK4QDSUk1i0DZN4/wEwSoBoy+njy1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914213; c=relaxed/simple;
	bh=9+xzVzStH5jySgGJiobWKMn8FjA+vNjP/UnkeGKkeQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ba8f6ihdKhS96u3VIwyFo1gxKAalENcZoWqkK5mAenuJoh7+eVqQrHHN/A+4cdEoM4Kv667qKUXvHZP5sZhuNeX910ScgOiTaYxLM7ksrog+OWGvh+p2rrekbyfVZQVB/liGkDfBfwUuCmeGtTJhSCt7CkizQIDYqvcvGe8IZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KS/v49wQ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS/v49wQ"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ab38a051aaso26228897b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791914211; x=1792519011; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I3urwFIjeTZMI3nHLcO9T0M+7OUsQOTZbc1ClGXMTLY=;
        b=KS/v49wQtLRLZZAlQ1bqq2v8qBx0YzbFBZizFvOrznpwGsTKv5wyAYiDJ014m91Y0G
         D+ATBHnlMiC5tyRQ7F4BfSOOQPVLo43U8pbp3dNLUJA+iaB82NT0dR1pl8je+Nx2kYVb
         BzQm5634DxkZpDi+jSMGTZkSO7aZ3Bn/cExU3VaDATz6YVx6I1zVN087HN6gHg2LBrl8
         6ni8oFem8r+vA+0UrQwTWD1NQ8R0NJlFnwktCIl0qCwWvKACU2wloeM3IIpf07MxTSAq
         kYQ4T4jFkalzhg04TmEL0PlQrzjatgcWReuukDr60DccjSUWVgO0wLSsG2IJzKkuKMXw
         uzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791914211; x=1792519011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I3urwFIjeTZMI3nHLcO9T0M+7OUsQOTZbc1ClGXMTLY=;
        b=JR6+k+eSZbQVL7jHs94SauWR6afhJq8qc2egeXShY/YpPSPfeHTyQSZguj362XJlCd
         jHlj9UyZY99dsuiT52SuUqWeFWiG4sHCvAXm7i+mCtngSzGDNfw8DigLGC0exrTHFz8A
         9RVYkp+DGikw+RcJsIF+XeojA+AsW1umSE6AIjsr1iaQJsCVjKyBkY+7GFpXUnXAHUqA
         TQiea9tfBD9zD/Hl9nRrUlD0dy6eZ0W38qio+dShQ7UbMm/MBMU8/R4WeSCwSYBhsNX+
         +9wXuXbO8Qm52WXJIE7KU5epb2UHBpY5UZGQlZ0/l8Ta1RqEdraqzPe1XjNyMATXg7uv
         x77g==
X-Forwarded-Encrypted: i=1; AKwUvBx2To4h+U3sA/CEk6RLhNUP1J7Nu4gZVF7k54TngmcGC0o8tf6qKckHxhl8w6ItKURKOrm5ZYsIe99nQWjb91WohOJZJBU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1Qnq9Q7SSb8FhaXsE7H6FsD3XHy/kOmTcgE2AzPjI0kQjP4es
	TR0UOR/tU8YqqhdMliLD4WkrYGR5nMhS0a7G5lR5rUHiJunbCNYLBNXP
X-Gm-Gg: AYBFou2NqSua3s1qzId2hWIxsJcrZZ8HzaAsako0tZD/Ccoa9figZ1mBgq0GpNT157t
	UiA4+gWmbfYc5H+VMJLRe5uoEnQTCmZ8xW2JFo1rQXlh1+XUJynkfu6gzGgQ9/ifJ98pJ0hiMA1
	UZZj3sDdMmz/6fmksChlMLaolmRx3qz8AswF4HoNtDOURKT6YGykY/iIXUp5p6mxRXND4f9sdy2
	WZMQZqnEEj3DSpE5KlP5tRBhP8ym5pDTTA+YpYBXbuuko0rpHTjUdWAqOjjBffZwmIWXU6YyHhK
	dw9ltCxCHz3jixsgk0btJl45PTZgWkTfH6uC/gCUv53eeDq8zUEZdvNP0EzwZH/QPPqw61BYBie
	wZqNhHIjXmNymUBjl3TpkgJukNIgT8AVzyjB17aQDiGaMN/qXUgcpN4VLViFfXKWD+iryIyv5OO
	nuM4/VR880yYSf8VAFQF/RTUqF6Se1IKG5Lb/h/LOxWBL0xm/W0yXQG9rW29Mn974mLd+LWZM=
X-Received: by 2002:a05:690c:c505:b0:8b0:a957:80c4 with SMTP id 00721157ae682-8b0a95786f5mr22590897b3.45.1791914210764;
        Tue, 13 Oct 2026 10:56:50 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d326:f863:5ae3:683])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f2508e0sm48386227b3.38.2026.10.13.10.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:56:50 -0700 (PDT)
Date: Tue, 13 Oct 2026 13:56:49 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 08/11] namei: add an rcu-walk mode to the
 ancestor walk
Message-ID: <as5v6B-8O2QQw3zC@zenbox>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
 <20261013164800.2906577-9-utilityemal77@gmail.com>
 <sashiko-outbox-170183@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-170183@kernel.org>

On Tue, Oct 13, 2026 at 05:01:26PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] vfs: TOCTOU race in vfs_walk_handover() sequence validation
> --
> 
> commit 1f35bee40e8028ac4b024dd5a54b6bbdbb5b8521
> Author: Justin Suess <utilityemal77@gmail.com>
> 
> namei: add an rcu-walk mode to the ancestor walk
> 
> This commit introduces an rcu-walk mode for the stepwise ancestor walk.
> It adds lockless progression using sequence validation and provides
> vfs_walk_handover() to transition an unreferenced RCU walk into a
> referenced walk.
> 
> > diff --git a/fs/namei.c b/fs/namei.c
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> 
> [ ... ]
> 
> > +bool vfs_walk_handover(struct vfs_ancestor_walk *to,
> > +		       struct vfs_ancestor_walk *from)
> > +{
> > +	struct path pos = from->pos;
> > +	int err;
> > +
> > +	err = __legitimize_mnt(pos.mnt, from->m_seq);
> > +	if (unlikely(err)) {
> > +		if (err < 0)
> > +			mnt_undo_legitimize(real_mount(pos.mnt));
> > +		goto dead;
> > +	}
> > +	if (unlikely(read_seqcount_retry(&pos.dentry->d_seq, from->seq) ||
> > +		     !lockref_get_not_dead(&pos.dentry->d_lockref))) {
> 
> [Severity: High]
> Is there a time-of-check to time-of-use race window here due to the
> validation order?
> 
> Evaluating read_seqcount_retry() before lockref_get_not_dead() seems to leave
> a gap. If a concurrent rename or unlink mutates the dentry and increments the
> seqcount right after the sequence check, the subsequent lockref_get_not_dead()
> might still blindly succeed on the active d_count.
> 
> This would yield a stale and unvalidated path position to the referenced
> walk. Should the lockref acquisition strictly precede sequence validation to
> ensure the sequence hasn't changed during the reference acquisition?
>
This is intended and explained in the cover letter note,
"stuff not changed" bullet one.

Justin
> > +		mnt_undo_legitimize(real_mount(pos.mnt));
> > +		goto dead;
> > +	}
> > +	to->pos = pos;
> > +	to->flags = 0;
> > +	to->pos_flags = from->pos_flags;
> > +	return true;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261013164800.2906577-1-utilityemal77@gmail.com?part=8
