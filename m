Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC7972613
	for <linux-security-module@vger.kernel.org>; Mon, 22 Sep 2025 03:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758511397; cv=none; b=W5Fkjm1LaZLi7+MpXuTpzwD+W2fTOnEOp3A9NjUHpbdTAc1e88zL01PFhoEdpK1ITGpn8iz7RV3126PwZUa9yGeCt03UP3mszO+9tYrmDBQ94GjAXQ4d6cyvD8377Rvz7QK+asudskjynWwHyc4ZlS6xBHaBr2jexUKYs7NFnSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758511397; c=relaxed/simple;
	bh=E/dcBmckf6s1cZOcdU6ceCyBy/PBSN1afXth3Qkt/8Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=irRq+iTJV5XgKH50HYVmflDhIpE+CKyWHSALojByqT0QUkbBAj4vLOAqsbO6CXHqKajRxlLB2x0P2OscE/jztOj3S9Ufg7cGgwjspPep9U6AyuLNR7GmcKtUZ1/eMKWwDFrOXFWARA5UrWo6PsOMs2+S4ICVOkrycClWZIpRFdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qowVR7c1; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qowVR7c1"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d601859f5so31141647b3.0
        for <linux-security-module@vger.kernel.org>; Sun, 21 Sep 2025 20:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758511394; x=1759116194; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FlwsER74cYqV32Cx96ZjhaczFHdoR+YcDNoqEmBa/E=;
        b=qowVR7c1wGXttdppv0v+Qj2ehmTK8srHEVnlX7swybKJd06q6F94qMZF5MhNh6bTWr
         Nn6LLwpK/GTwBXtcsySpNwC8fHZ958GocyVQiAgdDtCfwl9ofAQWSWHE2Muo6Q4kVB2V
         jQ9m1Q8+2zVYi/deG63wi3pWnjYoqFl9hCPUTJftoZoHph9bkUmUeOnW3cry8OjjPeD3
         N+iA6xdctGMlg3wIci1+qoHsY5BCE7AalDYINP72w6cFWp5QfibN9BUTrPPnmEEcjQRd
         Q0T1wFqooK7VH8QD5HOXZhDYcpV5WOr9K+xxPz11Wg8WtWrTasU0hBJ9GffL0bl360pT
         pDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758511394; x=1759116194;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FlwsER74cYqV32Cx96ZjhaczFHdoR+YcDNoqEmBa/E=;
        b=d+aGD6AyFBsvjWb4Uw9MMQA3Htk8k7SnXW0zMN8mQbbsogSkHzYv8Ykh0DKEhcggQg
         9L64Rbi5lKCRCX9hn8idWrm/3PIzxZ0snFVTnL4B6i3Zz5HHdqvvBWuiC4DY3bul/+0R
         +fOpoXFAOq5kNnZhXy5YokcSqT2pOY6M9x/ltdSKXl+YjuExIBDLbIJAbF6o6SMeWVMW
         hV8yyviUb3HF8DuVxLGdT+6wJBMRWgoj12K0Th+7wY84XjcxySc+/qOYesmRkDXPyjiC
         aDFWBVxQzxphogIeMUsuaHCAlISrbBlo6qbvlfZyNBLjOm3cMqSQ5Jm8SLOrFia1zKJi
         O9gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLo9r24x3jEjP6/wW+DXxoNslIqdVsX/LuW67eNqGbSqAAC0RANB1DOH5hmPY3mceJsOwWmxb58LE62oXvRVqA8eHvv8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC3jzdshwmOyfDGmjdkOCmun9akbcvAsSUfLk3eieUFJo7SY/y
	lJd4dkLzqijRafuOGSS9B341iEl6PfC5vUtAovoCG9EH2qGk7csqJvT/Gt6Y//s1iQ==
X-Gm-Gg: ASbGncs4KxWdV4ayB5l8/5M3n76UwjRSqltzvLfavy7ch2X1eC5ku6zsM7CJMU1ePtP
	r9q7gqQifsOYuc2xG+cdYLTW/Fo0X2DRI3aGPo3/AVBFirY4+JNwLXgqSitS2aCWFiPn7q3rfsV
	A/B6dU1tXVgr8Te8e0NiyiWLnjVNZq0/YXCcw/cH4rbRVA1aJOJHmF3FnkZbhgclkDebjqoVJ/i
	0wS+uyf3TYaty51mNotzb2VGXEsAl2sGHiR45ZIoK3Wca3ksP+dXpjRT96K+b9MEkrHc6CFZ1i6
	gttVP+8SQ7yvhTnVGp7XaUfCyfezqS4mQcMLnM0A0zo+Nkke3U6MLY9+0iZ4RryRUNuk1UZxuzm
	QKi29ovl7q1On8Docldi5J6yIwo7rFxq5Ffo9dEwkd0y+ufVRO62uBKdDjEbbHzAcG3N2jyJQIx
	Y/sYbRC74=
X-Google-Smtp-Source: AGHT+IHN/ys8gHLrLIlg7s+DKUjMBq+p6tvCq2COmIp5lBOsMogpQZbYlGnq/VUVqHpKXGstFcOJKQ==
X-Received: by 2002:a05:690c:5c02:b0:722:6791:c5b2 with SMTP id 00721157ae682-73d3237b3bamr95872717b3.12.1758511394225;
        Sun, 21 Sep 2025 20:23:14 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-633bcce8a3esm3798775d50.6.2025.09.21.20.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 20:23:12 -0700 (PDT)
Date: Sun, 21 Sep 2025 20:23:01 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Paul Moore <paul@paul-moore.com>
cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
    Hugh Dickins <hughd@google.com>, James Morris <jmorris@namei.org>, 
    Stephen Smalley <stephen.smalley.work@gmail.com>, 
    Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
    Jeff Xu <jeffxu@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Isaac Manjarres <isaacmanjarres@google.com>, linux-kernel@vger.kernel.org, 
    linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH v3] memfd,selinux: call
 security_inode_init_security_anon
In-Reply-To: <CAHC9VhSbWJ-8tj5BxSTxznGO8zraKRSE31a+tqdfMHB53ef-MQ@mail.gmail.com>
Message-ID: <a3f1a528-c2dc-74a6-b671-d8b2ccf23183@google.com>
References: <20250918020434.1612137-1-tweek@google.com> <CAHC9VhSbWJ-8tj5BxSTxznGO8zraKRSE31a+tqdfMHB53ef-MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-1534621582-1758511392=:2554"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-1534621582-1758511392=:2554
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 21 Sep 2025, Paul Moore wrote:
> On Wed, Sep 17, 2025 at 10:04=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@go=
ogle.com> wrote:
> >
> > Prior to this change, no security hooks were called at the creation of =
a
> > memfd file. It means that, for SELinux as an example, it will receive
> > the default type of the filesystem that backs the in-memory inode. In
> > most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it will
> > be hugetlbfs. Both can be considered implementation details of memfd.
> >
> > It also means that it is not possible to differentiate between a file
> > coming from memfd_create and a file coming from a standard tmpfs mount
> > point.
> >
> > Additionally, no permission is validated at creation, which differs fro=
m
> > the similar memfd_secret syscall.
> >
> > Call security_inode_init_security_anon during creation. This ensures
> > that the file is setup similarly to other anonymous inodes. On SELinux,
> > it means that the file will receive the security context of its task.
> >
> > The ability to limit fexecve on memfd has been of interest to avoid
> > potential pitfalls where /proc/self/exe or similar would be executed
> > [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
> > similarly to the file class. These access vectors may not make sense fo=
r
> > the existing "anon_inode" class. Therefore, define and assign a new
> > class "memfd_file" to support such access vectors.
> >
> > Guard these changes behind a new policy capability named "memfd_class".
> >
> > [1] https://crbug.com/1305267
> > [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google.c=
om/
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > ---
> > Changes since v2:
> > - Add WARN_ON when using unexpected class. Return -EACCES instead
> >   of -EPERM
> > - Remove extra new line
> > - Rebase on selinux/dev
> >
> > Changes since v1:
> > - Move test of class earlier in selinux_bprm_creds_for_exec
> > - Remove duplicate call to security_transition_sid
> >
> > Changes since RFC:
> > - Remove enum argument, simply compare the anon inode name
> > - Introduce a policy capability for compatility
> > - Add validation of class in selinux_bprm_creds_for_exec
> >  include/linux/memfd.h                      |  2 ++
> >  mm/memfd.c                                 | 14 ++++++++++--
> >  security/selinux/hooks.c                   | 26 +++++++++++++++++-----
> >  security/selinux/include/classmap.h        |  2 ++
> >  security/selinux/include/policycap.h       |  1 +
> >  security/selinux/include/policycap_names.h |  1 +
> >  security/selinux/include/security.h        |  5 +++++
> >  7 files changed, 44 insertions(+), 7 deletions(-)
>=20
> Thanks Thi=C3=A9baud, I'm going to merge this into selinux/dev-staging no=
w
> with the plan to move it over to selinux/dev after the upcoming merge
> window closes.
>=20
> Hugh, since the changes between this patch and the v2 you ACK'd are
> minimal and limited to the SELinux error handling code (see diff
> below), I'm going to carry over your ACK, but if you have any concerns
> or objections please let us know.

Sure, please do carry over my ACK - thanks.

Hugh
---1463770367-1534621582-1758511392=:2554--
