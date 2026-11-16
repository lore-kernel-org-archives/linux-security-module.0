Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794850652;
	b=jKSguY0ba1KPAKdkh/tdpG3ykFY0ol5UorCWNfN6abMpFv43LZ99mrK696AkqAyJF1AS
	 Owshxwa0kNdVfcd0Acsbe0dI5j3K8qIFXVWq5tNufSqfb2Ch7gDeqPLEw0lyVQacgbpr3
	 4fiuBr1/1/K/bhLhVxyrhZf3Il1VVvlZJ1dgP6AQsH8rWE63WNd/yxO4IYTxiTj0TizeW
	 dKfYJ63oF7N9jR58DqYqNqGbDI7kdSwqE2xPeyyJJauTvvyn942BLpdaXAvXQBcojR7mO
	 OCF0mEFw+DgPN6lP7IMdG+QlBz6Fmuxie32SIxefqrIxoIok7QmKZx0wRu/lJHPVWoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
	b=VvyzmWp6WW0co1qYrSqSshb4Yg77h8YW+RsBCsuVHCKO4IMApuhJ7oMffKcE32Y574LT
	 xYmN9NGkzvt3zxkVIJTsYdm6sEdMaUM1b02KuEa6qEcDZEBgWvTJe39SyQxXdgtfp56RJ
	 98cqhxhONHnoWLbhVIk0/akbvkgOeljqWGlBYc+NgXECP4ywMMioypq+GispynvluvxRL
	 qaT7ndxXI5VAwTwxyAaiWvUd0yXsV9oE5jaDF8AxS5Wpy0df1YSUZDZIyz7J5PvLYgqLn
	 z429V8/zkIalallnNAasZhImwQZsXNtn3wCr+ensmI0raR8gk3CWEdtUC7FRX/rpr2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wda5m4T+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4084F606A886
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 17:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4084F606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wda5m4T+
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b7245ab5e2so105386a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:37:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794850648; cv=none;
        d=google.com; s=arc-20260327;
        b=aFrYRHHK0fewFUzQiWXFgqrYXi1FawXvjt2llDBjvkdL68IVoTffm9zou0v5muyGKW
         nGIIsWNSY9d25Mp6/SD3gSMYi0N7bzCy885FPryxD+NaIo8QAY5h22SrE/VUrjAtvVex
         hPInG2uncXgk4yLhXdOtpUs4DcHSXP0FkRHHTlXEO2gvAPp1Jx6Lxge/XvKEhRr2g9sg
         TBi7iIYLID6Fahb/fwk4mRn7dxgcEjuKTdQH7RC2E3Ls9H+BKh1CkvMKL8R7StvWYOZd
         3Ol5rUp9hVYEFl1o3vZ+t4mtlT9fOp5ohIWWkgLpCdNid5B4tZNHGynePot+r/iqynaF
         hl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        fh=bEsAJ+TtRhlKVQdZgpv8f9T09oJ9gllenXQPLUK/kJg=;
        b=h9wlht/eSizEJ7lpr/idXNLDdpfy6rnGzx1C51oDrdD+qO9BXcm6O+WQ0Jywzr4q3v
         GFBNP7VtJSjz4Gcp1gqukq69hG9IgpXWFP5U5m7EHrHaThvPPVBpV1VxM2rtE17dlrJh
         k/80U0iFZVBSPImEgSULUv5rkya0n/10RzyYZMFHJgglhfiHRk5gANUUuhuEvXQnV09F
         DRiqCEyNp+LmfFcmAKbcLUw89wo/AMqi1O8kkXz3zfemkUkVbx7JgoTPMuKAWMpMBdWO
         R7bVCiSrpR79ZFbPHG0IOdc6+ZhXrc55vuEq3O4I1oApfUzBJkdZCWo0MCWEz8hvLtTq
         Lm2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794850648; x=1795455448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        b=Wda5m4T+Og74YNLartpajMnAcctT7hnb5haqi9hjLlBRa67TYcEPjf80gw45qsgIx7
         FMobW/aC2ZXQsUmoaLilVLeaESS9ODytholTX6ZkGdI39Z50BqAMQuVm0upEGdU/eTIl
         KzXBiwaEJY7eqa6p49n+ZePGE0YUDeVtz78JPQJb7w7ae3zRsyAfYOAEtJq8eS6befDe
         ANfoXo4rOnrr9cTK5CEQbvEa19yD1CMimOfBL7pxwr0U+pGpN6RB970vgsC2xV+kB6BG
         DqloDFELm5xz1LM2zdKvbUwHIwogDmvmrNVDo81Was00uh+K9TR8cjrFQWZvFUjBWrt9
         3Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794850648; x=1795455448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        b=IbTS97s6Xb6wDK8adABYWQx/h4y1j+WU4xlpb5pr4HFENx4ntJhthkWUY1D0Ngg7Nr
         YnDvhAOh5c/qHPFYfZkZnQDXYXMDJ91YVQ2Hi5tQsB1LnWi85JLRrVDjrjISOSDPEz+P
         F0/bCLBUoUdyAsKDIEn3Dq0t8w/0Y6jy5tHifuQfcxwktJJnSX0B4BeOiJqj/HDvsScK
         IpNHU7z87jX9cxHZN6AZ9If09z53OifYdDWVF05GUEsn5XGrw5s+LaH9Zs/pveTacxS4
         q+Pjh8whp8VI8hoPC/g8pHStUMYgaj3/BEZbUTnsh507QdDamZbkAN5wkHamEr840Mie
         p0vQ==
X-Forwarded-Encrypted: i=1; AL+hErEKoCksBhdUgstWu9W+08hN1Ttnkq1BKpKzjbqtioHBJDCGgFn256+SLGLAo+q47GEN6aapkn5Zmc2lkxiy66x8yOjX9u8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GkTcS0kQGzzAbUy3mXjfM3fZWvUFqS1PMl0qlmOXE64UrZagb
	+tSOOtHR41iqaUJTq+GpAscApzUQtlyZzTfkIW2K52nblwmchA25RjZJvzLSAreix81TNVef/Md
	8ToSlZdDkh7VNrZhqm3P/5HCSG0XGzuM=
X-Gm-Gg: AYBFou3H2FAZgGgQkGUpt3x0DewqQTM+LunedvT7V7m9coGnXvLuUdlxms8hLlcPGMK
	f/bE+aATkA+zw4bX07RgNTEu2miHxEBQ6SVLJZVYBwXqAW674TOD4zV6IAux1XZ2cnYuc6Bqdhh
	hBVyMjlFmrVLdxhE2Oic9lsp2v5QypeYjv19b1GE92iJxIE6XE8CXgZi+fsJkHMdwSWoa8H5ZJ4
	nZBEZc1S15UbS93ud9GSnOYOTxRHZhBs/A0JIQ2DMaap23My04qtjw1y05EI5stxiCqlKQu4uq0
	s30ov7EABK47Ajp67UT5Aa3BjUhqqvGZcPXKcZH6saZ0bymSBAZCptafVZobgh7P+RGrr6Qbwpn
	JFvgj4BpTWrRxJfS+pTfuMd2j0ZWIjeE1fyl0qLbMhEN36vqq6s+6cOD38r28XGrujITB2Q==
X-Received: by 2002:a05:6402:1598:b0:6b5:7250:d621 with SMTP id
 4fb4d7f45d1cf-6b859ae1a00mr134291a12.15.1794850647426; Mon, 16 Nov 2026
 09:37:27 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-33-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-33-8cbbea1cf34f@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Nov 2026 18:37:16 +0100
X-Gm-Features: AclHuK_sKnxFPAK3k65pZhjyZC94SJD4eZ9z2j_P12s3kyb9TMw6hurQcjyq55Q
Message-ID: <CAOQ4uxgPerkkG4ie0SyHVXaBD9VZN2wYfQpEAEi4hytn=ara3A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 33/44] ovl: refuse data-only layers on pseudo filesystems
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 12:10=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> The data of a metacopy file can live in a data-only layer. overlayfs
> doesn't look that data up when it looks up the file. It only remembers
> the absolute redirect and looks up the data lazily the first time
> someone needs it. So until then nothing can tell which filesystem holds
> the data of such a file.
>
> But a data-only layer has no business being a pseudo filesystem in the
> first place. All it does is hold the data of metacopy files and the
> regular files of a pseudo filesystem are kernel interfaces, not storage.
> So let's refuse data-only layers on superblocks with SB_I_PSEUDO at
> mount time.
>
> Data-only layers can be added via the "::" separator in "lowerdir=3D" and
> via "datadir+" by path or by file descriptor. All of them end up at the
> end of ctx->lower. So a single check in ovl_get_lowerstack() covers all
> of them.
>
> Note that regular lower layers on pseudo filesystems are left alone.
> Stacking overlayfs on top of sysfs keeps working.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/overlayfs/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 39d4d57dec230..719c2569dfeaf 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1237,6 +1237,14 @@ static struct ovl_entry *ovl_get_lowerstack(struct=
 super_block *sb,
>         for (i =3D 0; i < ctx->nr; i++) {
>                 l =3D &ctx->lower[i];
>
> +               /* Pseudo filesystems don't hold data for metacopy files.=
 */
> +               if (i >=3D ctx->nr - ctx->nr_data &&
> +                   (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
> +                       pr_err("filesystem on %s not supported as data-on=
ly layer\n",
> +                              l->name);
> +                       return ERR_PTR(-EINVAL);
> +               }
> +

How about we make this just a tad more restrictive:

                /* Pseudo filesystems don't belong in composefs setup */
                if (ctx->nr_data &&
                    (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
                        pr_err("filesystem on %s not supported along
with data-only layers\n",
                               l->name);
                        return ERR_PTR(-EINVAL);
                }

I could send this as followup patch, but since this version is simpler
there is no real reason to have the intermediate "only ban datadir" step.

Only the commit message needs a little more flexing to justify this.

Thanks,
Amir.
