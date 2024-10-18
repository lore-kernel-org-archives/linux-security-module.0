Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149BB1D7989
	for <linux-security-module@vger.kernel.org>; Fri, 18 Oct 2024 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263947; cv=none; b=QsREmz14x60Qlmy/5CHbwiikjzY8/XGgBurP6VLzLZQ1x0EtEfJkIR5a6mFJvH1GTQt/WvvwiqcwXAkMWyC+JIgJSMWcqFEAV0aMq6I6L2pwLiXBRfXoHqPE8XqtGm8DNJrR+RdcABAa30wKaA4cVbXhR2wIKe7dTKuj12anbuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263947; c=relaxed/simple;
	bh=VY+gOC6a4ZSs6CZ8Ns3SAUj2iHkxiyZBv5pZmVF9X+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAbJRPLHu9MEejY7lAd97VGNfbB9pgum/ZGJ2a0YyhW07yojXx1eRnzGtTcrOOcA4DkJR6+JUeX5U9DTRGw5O6eCnwy8yI8oVhdXxPnSsB6g/D9M4BWQhBLFLn7M9gjdBP5rzrQDrxnE2rMPT/c9MHpkuLXNA1bc7zSYEMl5YUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zcaJoHLm; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zcaJoHLm"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e66ba398so29274e87.0
        for <linux-security-module@vger.kernel.org>; Fri, 18 Oct 2024 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729263943; x=1729868743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VY+gOC6a4ZSs6CZ8Ns3SAUj2iHkxiyZBv5pZmVF9X+g=;
        b=zcaJoHLmZnptFNjmtbc/WSclLW6gBDOFuB0ikdayjxq+ZhvVbt7k/jgBGpRgt2cQeN
         y5W3znAnofIi8tIfofMq4BkpStjbexm79XVWhtrHjv8xHxJpY6191YLBHHe3EpX0lsoD
         2yvdzem5mdRkgc20wbfml0ZbyOAe7JgJ4TBBBrdkgyVpP6B24+mlwIatuhEiFsaWGLNT
         cfD/XCKafe2OruBfJhOZWFmE+RkcxK10NqJXcDZPNOeOoan8DUrggC3u8F820LQ4oHgb
         sLqgkvLPqVtFi9Q8wdKxvMVFa2dngFyrgrtQhcksFobe3k2nPuB+OQ4iLo+bESX/2U2+
         mwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729263943; x=1729868743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VY+gOC6a4ZSs6CZ8Ns3SAUj2iHkxiyZBv5pZmVF9X+g=;
        b=A9WaU9tMV7Bfrx0jFJCLJYg/sYPh0ZsPboDpGZ0oN648k7/phTuTRmQ1j0pi+ZMkzA
         t2FuPzWVbzQ5uYPB7rJXPFbHj8b5ZKV4cykI/6HEwxqQzg9FfGLoy6lbmXO9hx0RGpKj
         g31I0dPBcEF22xESK+4Q3Dy2nm545SGFDRIsNlq+pLLJ9MZJdSwi5wOsiMZ2rZcBW0gS
         1gEnMKV9KOwkIR0OHEAR2eLC/YnVk9ofyy4eiVyAGraC50RzR82mqRg6x2R8C4oGT9cC
         pDrG7PaJo/MswJdZ6aPauYTPf8gS2s3C72AS9XiOTlXxsDYHL9208pPRlNO2y6KFbWNO
         0qZA==
X-Forwarded-Encrypted: i=1; AJvYcCXFuKHLAAfdEghv36c7XFaBu/eV/qEy1VCZE6uHFKHOK/VHGjEl8HVVfcyzUaCi+ws/2jx2MOu/JCWG24X6qoqnzjfyvLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM2Bh2yege7ZFW052iR4rmMeylffx4FVKi7UWCl7pQ3qjQtEcW
	V5CUwUEr1B8RwMApnYlE6YFF62Z5fmvWJ0sD9d0NCJ1pYz7zESYi/IIQSANFrYS/JHHUvH379Qd
	ajmwyddjIbVGHbep+wOe6vBEJqd2/PwY7yzZS
X-Google-Smtp-Source: AGHT+IHEdjAuAnZpQTb3020lZcH6NNioXnQO8TFmyT8yTm8pf+QhIDKkj1QU/pK6ubOymnxvMFhGxeUvu4tJjCuhK2I=
X-Received: by 2002:a05:6512:31c2:b0:52e:8475:7c23 with SMTP id
 2adb3069b0e04-53a157613d6mr366525e87.7.1729263942596; Fri, 18 Oct 2024
 08:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018144710.3800385-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20241018144710.3800385-1-roberto.sassu@huaweicloud.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 18 Oct 2024 17:05:04 +0200
Message-ID: <CAG48ez1Bd7dWmXpMS2=f6gHoSxhySv2v3m5_BvucMNtC3AZeew@mail.gmail.com>
Subject: Re: [RFC][PATCH] mm: Split locks in remap_file_pages()
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ebpqwerty472123@gmail.com, paul@paul-moore.com, 
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, stable@vger.kernel.org, 
	syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 4:48=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> Commit ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in
> remap_file_pages()") fixed a security issue, it added an LSM check when
> trying to remap file pages, so that LSMs have the opportunity to evaluate
> such action like for other memory operations such as mmap() and mprotect(=
).
>
> However, that commit called security_mmap_file() inside the mmap_lock loc=
k,
> while the other calls do it before taking the lock, after commit
> 8b3ec6814c83 ("take security_mmap_file() outside of ->mmap_sem").
>
> This caused lock inversion issue with IMA which was taking the mmap_lock
> and i_mutex lock in the opposite way when the remap_file_pages() system
> call was called.
>
> Solve the issue by splitting the critical region in remap_file_pages() in
> two regions: the first takes a read lock of mmap_lock and retrieves the V=
MA
> and the file associated, and calculate the 'prot' and 'flags' variable; t=
he
> second takes a write lock on mmap_lock, checks that the VMA flags and the
> VMA file descriptor are the same as the ones obtained in the first critic=
al
> region (otherwise the system call fails), and calls do_mmap().
>
> In between, after releasing the read lock and taking the write lock, call
> security_mmap_file(), and solve the lock inversion issue.
>
> Cc: stable@vger.kernel.org
> Fixes: ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in remap=
_file_pages()")
> Reported-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-security-module/66f7b10e.050a0220.4=
6d20.0036.GAE@google.com/
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com> (Calculate prot and=
 flags earlier)
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Jann Horn <jannh@google.com>
