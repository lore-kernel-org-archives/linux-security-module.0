Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2778D3DEAC4
	for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356056; cv=pass; b=nuqbf4Ctm6WShGQaa5U7Pz/htpJC3pjsLu/y7gA8cS6yG2JQHporU0uCSMBIr0xScmaucXfACzyeRkGTFOyusPM3/YX1V9hTZYBeZuGqHFqFKg5SSqzpu05lDnWcoq16nEqdXKezsr5RTnQ5ruep12gKP8lI/9c9D4Ecd0milFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356056; c=relaxed/simple;
	bh=Z/QlDjEqmTsvd8hmVsRhjPJAPZKduCsAshcn9SEcHsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSqAq1YzJOwhK9jI1NMFXeh+09KGnHeupi0JBfgokPtEpS2OWR0ViVaet8eUiRWSK4vDmBoydngZVvRcMPLHfVpuNZNhxMVwMmtdeRhAOOfA/HTvbopT3o5Gu4kwgJj+ses6UBx/Dw8XHudCk9FQp/+o1G8I8s8FkcQ6oDgIhlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JQ7vBslB; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JQ7vBslB"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f05ffcso5102825ad.0
        for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 10:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790356042; cv=none;
        d=google.com; s=arc-20260327;
        b=l+lI6cmXvXl3vvyjkDFxYUZohA44l5nO+gs5qq6Crjqf6RnX/BIsvZmYXpU3sUWfFe
         VdvX/M37dh3fLsocQZ63ZQ0dW4Hl9WUc79FHgKY7MutVcOzn8/U1aNQhNJ4SO438xWxV
         9R/ut+ULno/OrCJSD/WO/v5dud43+euX9sisNImQXoOPmvO+mkXDa0mgwsTlZTg94eKe
         nfI8ct9oCyHgeQBgEPmzKzHGt8B9Sv2fmHJq8ve9mdcL+NxwLUX3QXQWtlbx+Mqsv1ru
         gzGBk0G+9r1ubqxd62wddbBd9l+HG7RN9/Zf7glRhudX4mw+uUZjCZgFQ04Lz3zCHqPL
         7x9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        fh=UGToMryMGBqi6O2GiEGRlsZH6NYNRQwuRBJGEqRJPBw=;
        b=NqUG31dRtY/4mO4SA35IlSR7mjYmptV2UkrZmZtg5DnWEHYKfl51unZD7xjmEzbffT
         ZnJSq7vhJFP5T/UyKIQGJrY1ccB8cDIZxId9eZPUrZdf2y+VLaOBvtruo8a17HodMl1Z
         itr26gjqFLIQOZxmIbnIsARE1xwDfWHKFmrbDKaUjDMgEUClHT4VdREl5aixofSf98EX
         Z64jX0RGBHUttXl/lQ75xIfIt6ktFByWtsPLMuseIP/ps1NTMjoSekU49IXbKXRQQavZ
         piorvJib1Et65bcJjMNJLMRq3zLjLW2wdqhZRC0oVpJXiyhTjztjSdjzdZt4mSlCTg54
         KCDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790356042; x=1790960842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        b=JQ7vBslBA75Oz3vhccuiegu2ZSCVFqSF0HyjC/3/vNzOkrP+yD6f4D4JjYMSYAoFrr
         wlg7Wmn6oEu7SXRotz0a67VZfHRO6XibZ9ZQ2iaB3D1nQj3Xnbu+DnvAmLPuwuabcTJk
         PXz37aU1zp89S9iK0/x3WEyWrQZ8hNLRiSYpSLIsFe52Q0ZtYHr08wUrk94pc3ENWlQd
         J+Tedgfpmw+/PX5h3yjumGEOqc+s3rcWYPx4Hn4luwZxasnr3NVcHxFxvCE/jfitgeBw
         +jOt/CmP2fD13Y486VYHbVYAPN3U4OMa+qtVuZhbWJD5jm5g1hu0o/Zq9FL93oXYU7V4
         vv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790356042; x=1790960842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        b=0wRpqKBBVuLElqY5z9fB4IIj8Z0EIoCOx1UCuNwKywvxCpqQZmvUhM5xdGE77zeBiv
         3xLF+GClXi5XcQObf97hix27cLZd42+n3r7q9WprETYObRpqjD11dit/NlNrsyxVNVq7
         do1ygz5UMm8XuDHmVZ8uxinWcDK7vn1SHJrv+jREinpzkUKd1xtzBxFMeWnhRyBw3/Ba
         kUIEYNQAHMb6JnVLkE/OLmXUITx/NkLE6FQpXHl5RAZJYrpaqJMscOKU3W6hXBoMzGv9
         FZJI8HbaPA78FUMmTSUMaI1Vdu7rdr8Lw+QMA4M3wNsUkgUYWuYSZpUOyUI5g5MbrmKo
         PlTA==
X-Forwarded-Encrypted: i=1; AKwUvBwGTAmNgr5Hocs3rdG/rLPmULQLSnvuKdb8w79S3S1GJaj5V884/Q/9c60hlYwmTHkiY2KruysCViz75cQmO/UcCshw1Gs=@vger.kernel.org
X-Gm-Message-State: AFuF++mZrl+fbwizyC28ZgPQ9KMhfHbT5rj8a8jzLk8yxfj4/c0wAjXd
	l/FXqSluOKJ3PmsU1umUlbtLuZgmWGIsZNDAJYLVwmLtnMyYyv6HOeki5cGEZZS178k6RPkoGdL
	+AvbrLLpNIq7LJuTe3P32JxXCbDVFuBWYDlxLF9xX
X-Gm-Gg: AYBFou2RYIuvEuJaC+WwRLepbULLz34brAVtHZXZHl72LZ6PZR6GRZsQEoy2CZse4yr
	R/2p4UIC7WHRhJ3aZlgGREnveFyrknw+iVYW9MPmz5LyIopJ1A+vUYAtHh6XTBmrccwm1AR5Mhq
	WvBCjWt6+cMP9+Wj9zFngdXLsNS6Kt25SJ9FH9YPpQwdDLYhOzIBn2hKaMm9/FEU1veTJ497Pk2
	19DJal7JacqtJS+KJrutgSIoVL+hbRWfP5vA6gT6SmIS7KqWJ56eVf81I26wUaDwrMfF7PSPFd+
	jbKteitfv4soNkh+y2k5O7B9WSp2Dp1Uicr0Kq4TQHzzkHrtWd53WzTvlfo2Nftqk+Ido6FbZlb
	uWudNOV9FFfj5n3OxPOsNnA==
X-Received: by 2002:a17:902:d48d:b0:2df:99e6:9448 with SMTP id
 d9443c01a7336-2df99e695bbmr12902675ad.61.1790356042370; Fri, 25 Sep 2026
 10:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924104831.1081137-1-caixinchen1@huawei.com> <20260925-zahnersatz-hielt-lerche-141893658522@brauner>
In-Reply-To: <20260925-zahnersatz-hielt-lerche-141893658522@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 25 Sep 2026 13:07:08 -0400
X-Gm-Features: AclHuK-PYyMWIn_xv6i13K6lF_3RP26uUOO_mtAnUMGHNcMrV5ydBitx8qn_ri0
Message-ID: <CAHC9VhSeXmOHvioZ12aVmnOtpP52-G=K_jS3K0fTSiCrDHStPw@mail.gmail.com>
Subject: Re: [PATCH RFC -next 00/12] landlock: Add READ_METADATA and
 WRITE_METADATA access rights
To: Christian Brauner <brauner@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Cai Xinchen <caixinchen1@huawei.com>, gnoack@google.com, jmorris@namei.org, 
	serge@hallyn.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, dlemoal@kernel.org, hch@lst.de, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, jack@suse.cz, dhowells@redhat.com, code@tyhicks.com, 
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	hirofumi@mail.parknet.co.jp, cel@kernel.org, jlayton@kernel.org, 
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, 
	miklos@szeredi.hu, amir73il@gmail.com, senozhatsky@chromium.org, 
	chenxiaosong@chenxiaosong.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnacek@gmail.com, casey@schaufler-ca.com, 
	nanx95726@gmail.com, djwong@kernel.org, daniel@iogearbox.net, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, exfat@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	xiujianfeng@huawei.com, lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 11:33=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Thu, Sep 24, 2026 at 06:48:19PM +0800, Cai Xinchen wrote:
> > This series adds two new Landlock filesystem access rights,
> > LANDLOCK_ACCESS_FS_READ_METADATA and LANDLOCK_ACCESS_FS_WRITE_METADATA,
> > which control access to file and directory metadata such as inode
> > attributes (mode, ownership, timestamps), extended attributes and POSIX
> > ACLs.  It picks up the work from the "landlock: add chmod and chown
> > support" series [1] and follows the coarse-grained grouping discussed i=
n
> > that thread [2]: instead of separate chmod/chown rights, metadata
> > operations are grouped into one read and one write right.
>
> This is mostly fine for me. @Michael, for the fs side of things I would
> give you a stable branch vfs-7.*.shared.landlock.path that you can pull
> once this is ready.

This is in my queue, but I haven't reviewed the changes yet.

@Christian, I'm guessing you will merge patches 1/12, 3/13, and 4/12
since those are the VFS changes?  Once you have a branch for that, and
we have all the necessary ACKs, I'll merge the LSM changes in 2/12,
5/12, 6/12, and 7/12 and then Micka=C3=ABl can merge the Landlock patches.

Are we all okay with that?

--
paul-moore.com
