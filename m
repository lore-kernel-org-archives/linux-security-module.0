Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28FA37E304
	for <linux-security-module@vger.kernel.org>; Mon, 11 May 2026 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529169; cv=none; b=BjtffzBQDmdfg91sCNDSas+wRIeIYEqTab1eGWtJHpJVaT4a85RqassvOuJ3TLzv9izz/Bxmb2+CPCKqFSNx2lM6c3lSs3Rj3G+U8+LlKxIBWP9UZzv69ql6O5Sq1UyogGWI7EpprVwLdMS8i+HLsPhYFS2KkasgVi/PIpi/xfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529169; c=relaxed/simple;
	bh=VcQxfTFcZTn9ONn/zVhnpsD0/DB1MuCe94obAIHqHbM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=KFeSKxzvB911tu92Z+GiFjXMo31RTk85PNJXqip0QMk402C9JTuW+FsVpSZAuoeHJIWABAN6R1EG+9DViXLs/8bQYGGheCtagB+VvS10IUDohPBWgfsnKyq1M005hQS3wlmsZlrnfnp0Lue4XJ33OtIHYkxZ73uj6Ox6lYkJQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=O1dCdV6b; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="O1dCdV6b"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-900fa9f178dso513314785a.1
        for <linux-security-module@vger.kernel.org>; Mon, 11 May 2026 12:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778529167; x=1779133967; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LL+UPYnZCOjrePrtqK6xOAZ5G7o1QmvEfzGseYDEIaM=;
        b=O1dCdV6bVCNE0S2myy/TKrzkIxIwfCo/LphzIaKwCvVQeB+DzL4643965DQCBP4/OL
         UA2ARqxufDGtcWp73ZPeUbFdiEuAv6eaHc+UR8k/qQSQb3FKvmZQ6T1MPDkXjIRcbL/W
         e9x3gemRAy+fVWrZ1pXRYxd44F+8/HuoDe528Mxq/P9pFaQDxqAkMZ9NSMponXPGQKRw
         SXYZ+0xIMxGVKNuvOC7zOM51JfdDgEXdAmwVbXtzD2TuPhG7onHGUhCpVSMNfWarhFdG
         8o83kvZHZ9OwUNAq6CaF9Om9E+QlEL4KKmMYKwepIMqeabRywZ1/DVdgA6EelFx/f1SV
         KMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529167; x=1779133967;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LL+UPYnZCOjrePrtqK6xOAZ5G7o1QmvEfzGseYDEIaM=;
        b=QSlMPRe+sOSqz4E12TRnS2yd+jHga2sPQv7/s1NlBdT/6zQ4F1K0ij+JSOd3q8nrmO
         avTuLZvfgoP0oasoHceR/P+fQdzOVa6wqzJUazt8G7sHQaqo8H+BFKqr6yy5v+KTBSRG
         iYMe0rZ6SiROeXkPRkNSslSEPkHhhP+TxhzoCm8roKkPnzN0/edcRIPg70bqhOiF8/WO
         ACiJo7OfsTzUIsDCQv9XyhjKEKWmwgxT032OA0c8lRcat4V6Ng8wABXtxomjGriS7nL3
         Zs0mDsd5xf0mA9GE3FXt4zQ2UVUPf9ewCrmVvTyAMQqprduTlN/AJQONnL0obVbgBmb0
         XUlg==
X-Forwarded-Encrypted: i=1; AFNElJ+knGICTfeD6/3YsJUqTNtpS3tKxuhX7F20IwbDl3EkpiCQs2xbzwkU+lFtpoHZgq23P5YtNpWr3Si0TIT0p0c4Fs0H+6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEnnGvA3c2YvTWzUQSxVTsGn2vO3erwz57agSNHoErzvcqEPe3
	vdmIv7dyTZ0a+Cbk8iLxzCcXuBnT7J6EnHJtfkJFLPhKWkHxy6z7dpZMljVVLG35Sg==
X-Gm-Gg: Acq92OFwOc8SxS8X7IeX7csAFPDfIqUwGmWqUhotso0lHuMNILMdCXNf6LcnY8DwSzG
	UBwsQVVRss59x2Y63MaBTRP5pYiK/sLeU4jqyKZV6YonwiyUno/KLuw/o1PKmYuV4RO5Gl4fG8P
	jnkXBzbBf8ncG9HeP+GUDaUNrmeYu8pNpYzqher0z9+uLaYMd2BSEWHHd3uKdKf0FqP+4Of8RiY
	dqf7cO2EIEpe1GN1hYXOwVsK+7+8anFTKOdUb9uH3mlsG8N17UNs4x0ghrngjW0ZPGb/6Yscgew
	Yt27IgutyhIM2ks9OtLlFvr4yMe3OyGYh/RaDv+u18bofDM4hNihienqSswqxf+A7Stn7TdeMRh
	oe+pbAQ7bpjfsURS1DkoIQXDmvOz+DMrooAvdKyPZ6oYNaWyal7ipbb7pDWl1omSStEvZkCv2ld
	0ECLVY3gbfH8p2icxBUgSEF6km5yDmZjefL3ndks2d+AHBevY9NVDY/nN6SzLkbhLHzcVQhjrFc
	jTTvT8=
X-Received: by 2002:a05:6214:2301:b0:8b5:e126:e77d with SMTP id 6a1803df08f44-8c1a2531e7emr167597196d6.8.1778529166775;
        Mon, 11 May 2026 12:52:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d450dcbsm322404436d6.45.2026.05.11.12.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 12:52:45 -0700 (PDT)
Date: Mon, 11 May 2026 15:52:44 -0400
Message-ID: <ce407923a8717656e21a9f59b45043d4@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260511_1539/pstg-lib:20260511_1103/pstg-pwork:20260511_1539
From: Paul Moore <paul@paul-moore.com>
To: john.johansen@canonical.com, georgia.garcia@canonical.com, Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, apparmor@lists.ubuntu.com
Cc: jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@I-love.SAKURA.ne.jp, herton@canonical.com, kernel-team@meta.com, Song Liu <song@kernel.org>
Subject: Re: [PATCH v3 3/7] apparmor: Convert from sb_mount to granular mount  hooks
References: <20260509015208.3853132-4-song@kernel.org>
In-Reply-To: <20260509015208.3853132-4-song@kernel.org>

On May  8, 2026 Song Liu <song@kernel.org> wrote:
> 
> Replace AppArmor's monolithic apparmor_sb_mount() with granular
> mount hooks.
> 
> Key changes:
> - mount_bind: uses the pre-resolved struct path from VFS instead of
>   re-resolving dev_name via kern_path(), eliminating a TOCTOU
>   vulnerability. aa_bind_mount() now takes a struct path instead of
>   a string for the source.
> - mount_new, mount_remount: receive the original mount(2) flags and
>   data parameters for policy matching via match_mnt_flags() and
>   AA_MNT_CONT_MATCH data matching.
> - mount_reconfigure: handles MS_REMOUNT|MS_BIND (mount attribute
>   reconfiguration) which was previously handled as a remount.
> - mount_move: reuses apparmor_move_mount() which already handles
>   pre-resolved paths.
> - mount_change_type: propagation type changes.
> 
> aa_move_mount_old() is removed since move mounts now go through
> security_mount_move() with pre-resolved struct path pointers for
> both the old mount(2) and new move_mount(2) APIs.
> 
> Code generated with the assistance of Claude, reviewed by human.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  security/apparmor/include/mount.h |  5 +-
>  security/apparmor/lsm.c           | 99 ++++++++++++++++++++++++-------
>  security/apparmor/mount.c         | 37 ++----------
>  3 files changed, 83 insertions(+), 58 deletions(-)

John, Georgia, are you guys okay with this patch?

--
paul-moore.com
