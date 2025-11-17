Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26023EAA3
	for <linux-security-module@vger.kernel.org>; Mon, 17 Nov 2025 23:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763420681; cv=none; b=M0ojtXGN6FwfO4NhpX9nvAraQbNw2KqQBBS22+rLOyVCmFmfP2Ed0byCo4VkmzTeOyOhvijT4X24QfDXKUik4HZri672xdsyrB3ykokAG3qx7sr4UcFoGzgNWUDlS5eypbuTQaJvGkSMyZgBz90LoXYzXwKMHK8mlHQAd1r6Guk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763420681; c=relaxed/simple;
	bh=i7DdhnG71ftd4i2m2G21HgRfKhN3UzNnHz1O3MhLXC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wn7T7qX/9hGkM6JFInbrsy0B6se06rLN+BPa9+hKjuH81CmneIYIh9CpWaOMont4j5uZvD2/1zmqly7G4zlly+44vdK961zml3EPUFQcMfPfYuxUMaEf8mlrkAN5f//DAq4EraJ+Bq5x3HeclScUFa+44H/2q1sFWdOVPNcotj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YmjZq2vE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YmjZq2vE"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-343ff854297so5256980a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 17 Nov 2025 15:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763420676; x=1764025476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67DqjyCI/JhVTsF1ULoiPuOUOphLY2mp3g5O7RzL6g8=;
        b=YmjZq2vEP3RrKkuynMuBECfzV/qmuCZcW2k5SrDDwNLrBwCjhC9leZeksspqC9Reg5
         7m1qs16aYUYUzMy31VgnfaRfQ925KDC/Wf0JDl3vg/7PHxxunMH/Nn6A8qpdHIeOgmKF
         SSalfOtnM6+aKcPi/R1diKoX6mzhOZoLeEgbC5txiQiK8mFtldLoRKhJhxkJw2YYx59r
         W0OtXAGkR5gvdztwjWl9g4n1k7D8tVL8dwrwiXVcU0tTMTY3u4bltrQMVL5eUp5spcvr
         GNGswPZEV3ZLiPG9FXx0fVQEcWAztc4A7KBMY/KmU8D+TNzUS8SypFep3kDas3TIZnAY
         J+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763420676; x=1764025476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67DqjyCI/JhVTsF1ULoiPuOUOphLY2mp3g5O7RzL6g8=;
        b=atLdxDAiTt1Ky26bqGtAw8SuBvfLYdDKKODS/Vmuvs/qub3+S2X52LC5HcpcCIc7MV
         +I5StF+Pt5yOqjOMSrNV9rPwH4ir7dgeSZ9avHZSlaHCcx9DQLm5uig33LVjHcrPulCz
         g5znz3Y4VIyl8HhqdnleUj5Pke0fjFzB0YP+K+k8vlzysyCKj6SX7EmyIbSfEc5ofrBz
         4OsY8ddbVee9ZS5YscwuQ+wFgIk/EVSewKytJ/UUU6pnTiBMnaPBkFKwSyoMh2FSKIVs
         mduQsJ6SVXG6klCbu/h/G3AiHmCmHJcHG63wFuU2US0d472uXu0ZI0wFXgNzrHOhMOb2
         c9OA==
X-Forwarded-Encrypted: i=1; AJvYcCUIgZ2aRqw8bQYlJusxEWNHG0c4QU1bN2hH4bJIy35bXZyc4jUn3LAn6gkovQCp1/zB+HR4SY7fe9maXtX0fCYsjc560do=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgG0WUBn2Ih99B5vo4HiHFa5W1i/tZ7KbqbKoUGBaYAOCaEBTo
	0ghvlBmqS8BQUZInwbJIwBGpf97exQxxk0kAl/Kd8/JqvIzSBhI/4oQmjy2pVp1CLN5tSc1wuBR
	r6YGYFU8vHvADX7ruyPv+SVnlSFO80fmhz2cABnFD
X-Gm-Gg: ASbGncsJY5aIHF/1F3UO7wphFnZUYX1EtceJBWucx+arHfFIE6nUDLNXHOKGq47GzHc
	jpWg7X/E4VbtFnuUIYavznTAQ1zyF+DUKVy4vjeWVbxxF25hjfTzqdk6F77opLgmS7R8tmpfMvk
	5MppXEHZVpgGD7CjAug1MrO1+y+OtYUhAdu0JR5wmFscb9H5sW/KDRG1lpLH7BPykmmsJsOz4Az
	oHPSzLNs9KLmHEQn6lcdmTLw/h80VJ5+nJ4sRm+S1nEREyH5w2QumI15M5QH69Os9ozoN0KnMyy
	PBnX+g==
X-Google-Smtp-Source: AGHT+IEvNsvH0S9IPXXRMbbmgzHTccG9PPI2nYN0bRiYDZkjLr7eZa3zFcl2Aq+G2oZCl+9tdbOi4J//UzL45yvj1Lw=
X-Received: by 2002:a17:90b:3a45:b0:341:2141:d809 with SMTP id
 98e67ed59e1d1-343fa74b235mr16121302a91.26.1763420676475; Mon, 17 Nov 2025
 15:04:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113002050.676694-1-neilb@ownmail.net> <20251113002050.676694-13-neilb@ownmail.net>
In-Reply-To: <20251113002050.676694-13-neilb@ownmail.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 17 Nov 2025 18:04:25 -0500
X-Gm-Features: AWmQ_blmwKtGFLQfMeJ-bOJqBB1-xlrqHYzasnjIoux8218WIXniQF0qawaCUpA
Message-ID: <CAHC9VhQERRrabQhMUd3DHRg+TqV6Ztoo0kqwK_tn5u--in-f4Q@mail.gmail.com>
Subject: Re: [PATCH v6 12/15] Add start_renaming_two_dentries()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	David Howells <dhowells@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Chuck Lever <chuck.lever@oracle.com>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Carlos Maiolino <cem@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 7:42=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> A few callers want to lock for a rename and already have both dentries.
> Also debugfs does want to perform a lookup but doesn't want permission
> checking, so start_renaming_dentry() cannot be used.
>
> This patch introduces start_renaming_two_dentries() which is given both
> dentries.  debugfs performs one lookup itself.  As it will only continue
> with a negative dentry and as those cannot be renamed or unlinked, it is
> safe to do the lookup before getting the rename locks.
>
> overlayfs uses start_renaming_two_dentries() in three places and  selinux
> uses it twice in sel_make_policy_nodes().
>
> In sel_make_policy_nodes() we now lock for rename twice instead of just
> once so the combined operation is no longer atomic w.r.t the parent
> directory locks.  As selinux_state.policy_mutex is held across the whole
> operation this does not open up any interesting races.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neil@brown.name>
>
> ---
> changes since v5:
>  - sel_make_policy_nodes now uses "goto out" on error from start_renaming=
_two_dentries()
>
> changes since v3:
>  added missing assignment to rd.mnt_idmap in ovl_cleanup_and_whiteout
> ---
>  fs/debugfs/inode.c           | 48 ++++++++++++--------------
>  fs/namei.c                   | 65 ++++++++++++++++++++++++++++++++++++
>  fs/overlayfs/dir.c           | 43 ++++++++++++++++--------
>  include/linux/namei.h        |  2 ++
>  security/selinux/selinuxfs.c | 15 +++++++--
>  5 files changed, 131 insertions(+), 42 deletions(-)

...

> diff --git a/fs/namei.c b/fs/namei.c
> index 4b740048df97..7f0384ceb976 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3877,6 +3877,71 @@ int start_renaming_dentry(struct renamedata *rd, i=
nt lookup_flags,
>  }
>  EXPORT_SYMBOL(start_renaming_dentry);
>
> +/**
> + * start_renaming_two_dentries - Lock to dentries in given parents for r=
ename

I'm guessing you meant this to read "Lock *two* dentries ...".

Otherwise the SELinux changes look fine to me.

Acked-by: Paul Moore <paul@paul-moore.com> (SELinux)

> + * @rd:           rename data containing parent
> + * @old_dentry:   dentry of name to move
> + * @new_dentry:   dentry to move to
> + *
> + * Ensure locks are in place for rename and check parentage is still cor=
rect.
> + *
> + * On success the two dentries are stored in @rd.old_dentry and
> + * @rd.new_dentry and @rd.old_parent and @rd.new_parent are confirmed to
> + * be the parents of the dentries.
> + *
> + * References and the lock can be dropped with end_renaming()
> + *
> + * Returns: zero or an error.
> + */

--=20
paul-moore.com
