Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF71F2253EE;
	Thu,  8 May 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714172; cv=none; b=QmnzCJ6TcDLrhn2yQ0Wh3OxvTM6kBduTJwr0KFzoghSCei0oJjMsIJ0Jyliim/uxop3RsnkmdGcezPZc3gux/IS9KdRcnDI16uA/66ZcTrJ9WRnYRgdo/SFAo+IcFflYQ6j0avSHKGlZiaAGRabJPsymo8ydzg9TuR3DTv7c3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714172; c=relaxed/simple;
	bh=L2A53b1SBH/XBk3vKsdtqa4zJbsmfjiXiuTZlUXMN+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUzZkAHjlPcYfuHavaojTc6vHs9Rlc+sr4S/H10So4lwCOyI4hXNVqvhZ+1Zu2ejvaMc8MRaK8OJj6bGeqdW/vFvEqT2Hynoelu76viIaAONpDgA2/SWb8xFD/ddkQBYvZioxFb+R4nIONNRyFjvZCbuoU5ENu0PSOevL8ycwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOekj9YY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOekj9YY"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22e45088d6eso15050655ad.0;
        Thu, 08 May 2025 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746714170; x=1747318970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvnCu4IDT4LGeI/g3VmpbphZW2h1OyuyN6JvDGAvzTQ=;
        b=kOekj9YYMP6Uc4Wp+b9skXmqIovGl6Y606NlrN4NTLJfAtj5rsuF+UYJ4380ig83xr
         oM8NmcD4l9ffCJCYIGx1DmcgZjDHTZZOcimyCx0RSqbfSlRPCmhRh07hQ66DjQh0L4Yd
         hf4uXcWDc9ALJnH3n4JeetNDcDjJfEENVzu/W6usptDn4Rq6/T3Fyds/kWgZ5gn1PXuh
         r0cGK3WLvMDQdTPjdr39VigZ5xyjfbNxbBHgZIDhVS9uvyvoiZhOB3HAZnV5o50dJ7X9
         QEmrTWi3U6x6mfrwqw3UCeBD4eZr8XecElShUKDh5ZCOrKQXvgASDjTpuE7Iuxo2bSnB
         Lafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746714170; x=1747318970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvnCu4IDT4LGeI/g3VmpbphZW2h1OyuyN6JvDGAvzTQ=;
        b=VHK1poIQY+j7GkYzDwaOVfAtqnPfkPWqel6eejrDszj6fY7KGjK+oIniGy4diNZKBa
         y1/hoAhwgc8qWBLKMUiuRHN+5xhVSBk8e99XLTphKQ75ffCBypjiiNfGqKQ5RWU/twnj
         jpvMaCfQ/+26zE+tZx8dOK7xuGDRMa2RcdqM5ah9wkmAUp05UMWD5jCHlkYpzfNXG8Ar
         wbjhs23Fkne7U1fjn4TsebBFKTrzE24RfoiHIiDgAKbOn+Ef5CL44UMuPsv5zqeHIiT6
         N0MZm3AlMxFeAOtbBptlxQuRreic6YtOo8hDkOiv7DUGkhlNtS3124cjqoybkHO4YH6V
         tXBA==
X-Forwarded-Encrypted: i=1; AJvYcCWNhSlvKVUGJbNNhf3imIeQt1iQOxkkDAFgIMzSTqEWq0/vZuUfQD103ZpjOwjAgbtP5AVjN6COM+a+sOYqOvYzoT4t3Fa2@vger.kernel.org, AJvYcCX6cHtGWAVfyIommJe79khavhozgkelFSCMU7qebS4ug7Y6mRCzeVMd6BgCrOSrbxDR764OsEGFQ6Arxss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59aqvsJgPl2GIvPZ2UAHz3dRIJf+xOUVc+zP8owFaJNxW5+GN
	JepSVvhAAixHMD+lTZ3AJf2DnbjRMZ6QMc2O0jVfuldmsjdMOPwc
X-Gm-Gg: ASbGncsTtRJ1tAt2+DKxdRVL9jz/bXQYsKHpdmqqS3kf2jAzS6hcSJFJtHpeJ85yQR4
	fQ22/HYNfW9mT6lSDf1bC4HNQRgjIvCebuQhn1TRe62q0jyr3JsLNiOCTxcOga75Wlpiygapzxy
	7wVmGE4jBj6KIVABZx34D7BMcouTgniqLwLw12rV455yQQoOTzFOA13mcbA4bR5G+goNDQCWJ5p
	1bWKC4H2IhzEbC36FAUZ7p66w3zCzWwzTf2N63HMsv17qrCQjJU+qXYQ+lta3gSvsmLAooYl0t4
	129ZkuVLa73L4k24MjIffNNvzoaGKaU3k6bdwMCUWYT0xCxLjPw=
X-Google-Smtp-Source: AGHT+IEpPz9g3uccJ8NXeUz59v7uobeMoLUYcXoSIjvFQ2UXU3lIbBbeHE1kJWqAB1HDb6q5luSshA==
X-Received: by 2002:a17:903:41c1:b0:22e:4cae:5958 with SMTP id d9443c01a7336-22e5ea782b0mr92345145ad.18.1746714169736;
        Thu, 08 May 2025 07:22:49 -0700 (PDT)
Received: from VM-16-38-fedora.. ([43.135.149.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e173b584csm108021635ad.16.2025.05.08.07.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 07:22:48 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: paul@paul-moore.com
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	chrisw@osdl.org,
	greg@kroah.com,
	jmorris@namei.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	serge@hallyn.com,
	wufan@linux.microsoft.com
Subject: Re: [PATCH v2] securityfs: fix missing of d_delete() in securityfs_remove()
Date: Thu,  8 May 2025 22:22:44 +0800
Message-ID: <20250508142246.648785-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAHC9VhRx6SUqYHm7Nv6JKVzpANsnt-qPONcVqZh=hXOsWMqDBA@mail.gmail.com>
References: <CAHC9VhRx6SUqYHm7Nv6JKVzpANsnt-qPONcVqZh=hXOsWMqDBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 7 May 2025 16:10:11 -0400, Paul Moore <paul@paul-moore.com> wrote:
> On Wed, May 7, 2025 at 7:12 AM <alexjlzheng@gmail.com> wrote:
> > From: Jinliang Zheng <alexjlzheng@tencent.com>
> >
> > Consider the following module code (just an example to make it easier to
> > illustrate the problem, in fact the LSM module will not be dynamically
> > unloaded):
> >
> >   static struct dentry *dentry;
> >
> >   static int __init securityfs_test_init(void)
> >   {
> >           dentry = securityfs_create_dir("standon", NULL);
> >           return PTR_ERR(dentry);
> >   }
> >
> >   static void __exit securityfs_test_exit(void)
> >   {
> >           securityfs_remove(dentry);
> >   }
> >
> >   module_init(securityfs_test_init);
> >   module_exit(securityfs_test_exit);
> >
> > and then:
> >
> >   insmod /path/to/thismodule
> >   cd /sys/kernel/security/standon     <- we hold 'standon'
> >   rmmod thismodule                    <- 'standon' don't go away
> >   insmod /path/to/thismodule          <- Failed: File exists!
> 
> I mentioned this on your original patch, but I'll mention it again
> with a bit more of an explanation behind it.  As you know, we don't
> currently support dynamically loaded LSMs, which means the reproducer
> above isn't really valid from a supported configuration perspective,
> even if it does happen to trigger the behavior you are describing.
> This may seem silly to you, but you really should stick with valid
> configurations when trying to reproduce things as sometimes when
> developers see an invalid/unsupported config they may stop reading and
> dismiss your concern with a "don't do that!", which is surely not what
> you want.
> 
> At the very least, I'm personally not sure we would want an
> invalid/unsupported reproducer in the git log for the LSM subsystem.

Thank you for your reply. :)

To clarify, the reproducer code never invokes security_add_hooks(), thus
this clearly does not constitute loading a new LSM. 

However, if you believe the current approach might be misinterpreted,
my v3 patch is available for consideration:
- https://lore.kernel.org/all/20250508140438.648533-2-alexjlzheng@tencent.com/

While I personally find the v2 reproducer more readable and straightforward,
I fully defer to your judgment on this matter.

thanks,
Jinliang Zheng. :)

> 
> > Although the LSM module will not be dynamically added or deleted after
> > the kernel is started, it may dynamically add or delete pseudo files
> > for status export or function configuration in userspace according to
> > different status, which we are not prohibited from doing so.
> >
> > In addition, securityfs_recursive_remove() avoids this problem by calling
> > __d_drop() directly. As a non-recursive version, it is somewhat strange
> > that securityfs_remove() does not clean up the deleted dentry.
> >
> > Fix this by adding d_delete() in securityfs_remove().
> 
> I wondering why we don't simply replace all instances of
> securityfs_remove() with securityfs_recursive_remove(), or more likely
> just remove the existing securityfs_remove() and rename the
> securityfs_recursive_remove() to securityfs_remove().  Do any existing
> LSMs rely on securityfs_remove() *not* acting recursively?
> 
> > Fixes: b67dbf9d4c198 ("[PATCH] add securityfs for all LSMs to use")
> > Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > ---
> > changelog:
> > v2: Modify the commit message to make it clearer
> > v1: https://lore.kernel.org/all/20250426150931.2840-1-alexjlzheng@tencent.com/
> > ---
> >  security/inode.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/security/inode.c b/security/inode.c
> > index da3ab44c8e57..d99baf26350a 100644
> > --- a/security/inode.c
> > +++ b/security/inode.c
> > @@ -306,6 +306,7 @@ void securityfs_remove(struct dentry *dentry)
> >                         simple_rmdir(dir, dentry);
> >                 else
> >                         simple_unlink(dir, dentry);
> > +               d_delete(dentry);
> >                 dput(dentry);
> >         }
> >         inode_unlock(dir);
> > --
> > 2.49.0
> 
> -- 
> paul-moore.com
