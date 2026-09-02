Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7532A39B4A5
	for <linux-security-module@vger.kernel.org>; Wed,  2 Sep 2026 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377713; cv=none; b=MrMbUoviKNOD+ICrne9ZpxxCEUnKV8MLthcqIXvqML7sgBzsZFw4Aq1tfQDSDoaoOjj5xiMzIkkvpTNxNFbgC1ShwtvKnNQRWHWIvTbzrvBz02QHqOVpWeFzDwBy9nNmFxLc/nNaNW6t5FvpiHABlvq+wTzL5PCD31RyPtDgjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377713; c=relaxed/simple;
	bh=9YDoT9jwp8RfcqmUzmkrtAhWc+TIQ8qBkmrmT7QKAu0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=rvCk/5Q9jEAqlN7d95q3W+Rs9tBuCJlcsN3LQDF9FcOnRi9WhKI54Bu7X/HF4jLPRrayq6lIfly2qEwB2Wbb4E/RLMarplJFHzIBqQ8n1VRWoXs8zBYrjb4uRw+tz+E/if6vX1LRJ65NglLidmnvRA12cJUSlgHs86ZPMMfJsCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dnAgmBub; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dnAgmBub"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9309d4ea213so175448285a.1
        for <linux-security-module@vger.kernel.org>; Wed, 02 Sep 2026 12:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788377694; x=1788982494; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GmC/3FuDYcsm/y4BEp+cIEvZVzU1YcpC+9hZf0Nce20=;
        b=dnAgmBubzItCWoW33zQ/cr6kWmF4Rk2Mzkb8dOowwzfxGpXFGMBwxM65QfZSd821Ap
         7ttC25x9+D/mO6vn5MkIV24PbKTo9Vt6kIPas1lPB1pEzgdWSlwBAd3+bdxaApR/U71l
         rtZ6t1XtkEXjp95KW9kdMSF2hgvloIQ2NalxBCIQesnwQOuIPnLnmtlMiKyodYHWYLV6
         b+L33zYO1RuwM6ia6I1kEDT88db9HPsVKBEezsg2uLw/hyT0mU7Okca6f/iovh/Ra1Nt
         qBq5iOngSjEQhLoApD/73uQwexipUWiOf1fXu/zQVcMCkpXGymML66jn94RfN/dR2xV6
         K1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377694; x=1788982494;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GmC/3FuDYcsm/y4BEp+cIEvZVzU1YcpC+9hZf0Nce20=;
        b=bab/UWQj/mlnr/S3rhJ1NT4tccbIjNnjr/JF/nlkc9tLlULQwv+knQsBZ5OZmAxd34
         NUEClY88Dw9KcOQvk2haA8yOPzsOHdsn9lfXUZxHJik1LZMBy+gyxY4nqiETztF6cRMy
         ZXmXb3OfF/zljAq0xoMO0nRNPCX4SCfDAKuDHK1+001zCxILaX7NLmEoAsjkoEmeEHk+
         LPaI7g25V6G4I0mFcSCbQoj0X5x/TkIFyhtXN67mscd91iJNbc2Fess1o2TocWj1XZ29
         hye7wv0xyF245+4fCjAJAKOXnExDGlNjcZVq/IEIpgJJNmuAgXoB/OVSeh+S40o5rbxd
         LARQ==
X-Forwarded-Encrypted: i=1; AKwUvBxXbtq2K5b+3H8qRjcx0t6SlmDS2UPWk0lB++0e9AI1hJMS8q2SChFb/oyNm8ACHjFg0uOexqCaRJK7elc9Iyvx+wkBYFE=@vger.kernel.org
X-Gm-Message-State: AFuF++kz8g4j/yKPtMerkhrK5xFH4lKXVTzyRFKoBRIb0b3HvmSBnx+b
	RrPe639cFHImIhUxGnQcBPiQgovLobswYQVMNxGL15wUsnSuXFrWNMfut/4lbw+EWg==
X-Gm-Gg: AYBFou00XLO4vWoH/rRRHXObBCiVKWfmKxXIm79caWoMppJw/j6ownaUtaxvQLaEtG9
	0/7qZS2zoUNdqzPmzpWxPEDr6G116xw5H2fj/foE2Mwl7YofzsACWrWcPHr+PXZrdh2hJ/D7XtF
	UYy/gDlgxdJnwtu3XG9iDWBY0UkzQBsxMB9dwf3RiFX/m8LGZNRYFeg0n3BAFx3u91eKvSmfPhL
	JylnEx7ekp95YJJScOS5VjoCoBtIqIPhKpvj5D6z30IkgFK6I0Ggzt5aAvMb5SsExJOL2mcbEs/
	Ls+dm/gv2nJ/WL97F5eEp7WtR5cRx6sw+6hHhIjRzSugvlRPCwBNp0/9QYpWHA1VdahgeUvH3qx
	5rv1ESw9v14qJWojkvLQ9AX5HSDOTFj9wwDKdXuVEwPrpCK00c3mT/3G1+1E8Fal+oqUBELf0tP
	VqfZS6HCLEVp67eOpPlgSsk5RCCvrOM3nkt0Kf4W5VuQCPGRnMWwcaS6NmWNUL24JOs2myzqUzN
	5VRGS+nRDboVetSsN22Tqm0lCgJ+FJ1dw==
X-Received: by 2002:a05:620a:172a:b0:936:dbd7:fcb3 with SMTP id af79cd13be357-93960f15d45mr864484285a.21.1788377693773;
        Wed, 02 Sep 2026 12:34:53 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f3b3c2dsm291721585a.41.2026.09.02.12.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:34:52 -0700 (PDT)
Date: Wed, 02 Sep 2026 15:34:52 -0400
Message-ID: <0e3057eefea20157b73a9e454a501961@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260902_1319/pstg-lib:20260901_1604/pstg-pwork:20260902_1319
From: Paul Moore <paul@paul-moore.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Seth Forshee <sforshee@kernel.org>, linux-security-module@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH 18/27] fs: port ->mknod() to pass const mnt_idmap
References: <20260901-work-idmap-const-v1-18-54ccd48e100b@kernel.org>
In-Reply-To: <20260901-work-idmap-const-v1-18-54ccd48e100b@kernel.org>

On Sep  1, 2026 Christian Brauner <brauner@kernel.org> wrote:
> 
> Convert to const struct mnt_idmap.
> 
> A mount's idmapping is immutable. The only thing that is allowed to be
> modified afterwards is the reference count and that is hidden behind
> mnt_idmap_get() and mnt_idmap_put(). Everything else only ever reads
> from the idmapping. This is the same model that struct cred uses and the
> idmapping is also rather sensitive.
> 
> So make the idmap argument const wherever we can. The conversion is done
> from the bottom up so callers can continue to pass a non-const pointer
> to a const parameter until the conversion is finished.
> 
> No functional changes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  Documentation/filesystems/locking.rst | 2 +-
>  Documentation/filesystems/vfs.rst     | 2 +-
>  fs/9p/vfs_inode.c                     | 2 +-
>  fs/9p/vfs_inode_dotl.c                | 4 ++--
>  fs/bad_inode.c                        | 2 +-
>  fs/btrfs/inode.c                      | 2 +-
>  fs/ceph/dir.c                         | 2 +-
>  fs/ecryptfs/inode.c                   | 2 +-
>  fs/ext2/namei.c                       | 2 +-
>  fs/ext4/namei.c                       | 2 +-
>  fs/f2fs/namei.c                       | 2 +-
>  fs/fuse/dir.c                         | 4 ++--
>  fs/gfs2/inode.c                       | 2 +-
>  fs/hfsplus/dir.c                      | 2 +-
>  fs/hostfs/hostfs_kern.c               | 2 +-
>  fs/hpfs/namei.c                       | 2 +-
>  fs/hugetlbfs/inode.c                  | 2 +-
>  fs/jffs2/dir.c                        | 4 ++--
>  fs/jfs/namei.c                        | 2 +-
>  fs/minix/namei.c                      | 2 +-
>  fs/nfs/dir.c                          | 2 +-
>  fs/nfs/internal.h                     | 2 +-
>  fs/nilfs2/namei.c                     | 2 +-
>  fs/ntfs/namei.c                       | 2 +-
>  fs/ntfs3/namei.c                      | 2 +-
>  fs/ocfs2/namei.c                      | 2 +-
>  fs/overlayfs/dir.c                    | 2 +-
>  fs/ramfs/inode.c                      | 2 +-
>  fs/smb/client/cifsfs.h                | 2 +-
>  fs/smb/client/dir.c                   | 2 +-
>  fs/ubifs/dir.c                        | 2 +-
>  fs/udf/namei.c                        | 2 +-
>  fs/ufs/namei.c                        | 2 +-
>  fs/xfs/xfs_iops.c                     | 2 +-
>  include/linux/fs.h                    | 2 +-
>  include/linux/lsm_hook_defs.h         | 2 +-
>  include/linux/security.h              | 4 ++--
>  mm/shmem.c                            | 4 ++--
>  security/integrity/evm/evm_main.c     | 2 +-
>  security/integrity/ima/ima_main.c     | 2 +-
>  security/security.c                   | 2 +-
>  41 files changed, 46 insertions(+), 46 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> (LSM)

--
paul-moore.com
