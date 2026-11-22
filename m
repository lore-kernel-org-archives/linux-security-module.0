Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795311934;
	b=T2J6ZlGvrol+XngT3c3GbFUzYSgPYfnV1mR1d80JMv2IukBSAcCbKiI7ujaHbql8jTEm
	 o9yygS3m/CyyVU0Y4jCqviPDrU2ozEcSnJxf6YlaxxW577jzFZgoVstYAFtYriIkXaJsU
	 kPuSta4ggfymHmSjJ686y86B0SHIAwxzlS4/vFuUY45PJEIDSp2eaBpE/OO8DgpavjANK
	 rxeGVZ7LKKQxAHskXpLXMdHH3JpNK0rlwkVdTsMEbvpAklBpiyOOLWFyjnR9+/9V6tdkR
	 oVqrL+NW91XRh9rNh4d49UshSZuA/YuhxN3dDjNOkV5csBEcvca5LmJOuCZ+JdNrhaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795311934;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EM4+43T1scJ6GiZV72AEDDRm99LdMgBsCTmaQ1zQpII=;
	b=J7eTQ/3dVc6vursv4aaT4aZuF3NhWzs+TADnZLKe7l9dbvfJt79cY3VqbKLI7nmFtS5z
	 nXNnLcaDCVwNrVP6Ca+qBG9aeWWvvjQxjkGvZez8YGlYwjnmajYcupW0VsuK7Ct433sNW
	 HKemL45ghSsvD8aqFRJQkXhC4puSiZdmhAIozS1ory6C1YXyw5x9S3DyOphKFtX5IBSGm
	 RF4vS2HB+Rffd/l8cP4IFDThtQWu1jNEv9P73DrQNv6Rpujq1UzxJvjOsVNg/awvSH2FN
	 5jvLP0sonqZguchqCtVrCCOI2jneAkS1nAHf7gePHo+THoX+JjH4tfkS8RcIrPEpk2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7ylMQXH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D8A606A32A;
	Sun, 22 Nov 2026 01:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7ylMQXH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3827C1F000C6;
	Sun, 22 Nov 2026 01:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795311934;
	bh=EM4+43T1scJ6GiZV72AEDDRm99LdMgBsCTmaQ1zQpII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k7ylMQXHqxOS6ixuIq1rwku3yNvoV4i3bvxJugzgrobnxWDANUB5vTb2Qh3Wcvbr6
	 4Nrcq8Gc2yLW2lzX5pnlaRyDCCXFFus4TRRqV3JalRCqnme8teQjct66FX8MRxbNbY
	 bPaSHEkoGM4oR3YZrRj8z6ZrkSllUsJ6f1jp2XupqeJVuqHxgdd3mENwQiB3NIoRU1
	 B6iL1iv0L9jre2aNbiSYdTCaEKWAK1BOxVQjQh6T1Lf1XuYr5DhJM6FFGsC8vtGiDY
	 1mjb5uOFb/GcMDqwaEXENYoj0/SyWymdtbyzwaGVRzdaxd04BiiG4IY3vEy+cx6oDl
	 J5AVekoLhjPUg==
Message-ID: <sashiko-outbox-227631@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v6 18/26] fs: Support FSCONFIG_SET_USERLAND in
 fsconfig()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Aleksa
 Sarai" <aleksa@amutable.com>, "Alexander Mikhalitsyn" <alex@amutable.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Andy Lutomirski" <luto@amacapital.net>, "Arnd
 Bergmann" <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Giuseppe Scrivano" <giuseppe@scrivano.org>, "Hugh
 Dickins" <hughd@google.com>, "Jan Kara" <jack@suse.cz>, "Jeff Layton" <jlayton@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Josef Bacik" <josef@toxicpanda.com>, "Kees Cook" <kees@kernel.org>, "KP
 Singh" <kpsingh@kernel.org>, "Lennart Poettering" <lennart@poettering.net>, "Neal
 Gompa" <neal@gompa.dev>, "Oleg Nesterov" <oleg@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Serge Hallyn" <sergeh@kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Zygmunt Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261122011809.2667684-19-jarkko@kernel.org>
References: <20261122011809.2667684-1-jarkko@kernel.org>
 <20261122011809.2667684-19-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 01:45:32 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] devpts: missing fc->user_ns uid/gid mapping check in
  devpts_parse_param()
--

commit 3b686423ce72875c03141d25884aa118403b95e4
Author: Jarkko Sakkinen <jarkko@kernel.org>

fs: Support FSCONFIG_SET_USERLAND in fsconfig()

This commit adds FSCONFIG_SET_USERLAND to bind an fs_context to a target
userland's user and network namespaces before parameter configuration, and
opts tmpfs, ramfs, and devpts into FS_USERLAND_MOUNT.

> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index bd1e8eb26edb7..921b67d18fa2e 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
[ ... ]
> @@ -457,7 +459,7 @@ static struct file_system_type devpts_fs_type =3D {
>  	.init_fs_context =3D devpts_init_fs_context,
>  	.parameters	=3D devpts_param_specs,
>  	.kill_sb	=3D devpts_kill_sb,
> -	.fs_flags	=3D FS_USERNS_MOUNT,
> +	.fs_flags	=3D FS_USERNS_MOUNT | FS_USERLAND_MOUNT,
>  };

[Severity: High]
Can opting devpts into FS_USERLAND_MOUNT allow an unprivileged user to
create slave PTY device nodes owned by arbitrary host UIDs and GIDs that
are not mapped in fc->user_ns?

When a process in init_user_ns binds a devpts context to a child userland
via FSCONFIG_SET_USERLAND and passes uid or gid options, fs_param_is_uid()
and fs_param_is_gid() resolve them against current_user_ns() rather than
fc->user_ns.  Unlike shmem_parse_one(), devpts_parse_param() does not
verify kuid_has_mapping(fc->user_ns, result.uid) or
kgid_has_mapping(fc->user_ns, result.gid):

fs/devpts/inode.c:devpts_parse_param() {
    ...
	case Opt_uid:
		opts->uid =3D result.uid;
		opts->setuid =3D 1;
		break;
	case Opt_gid:
		opts->gid =3D result.gid;
		opts->setgid =3D 1;
		break;
    ...
}

devpts_pty_new() then assigns opts->uid and opts->gid directly to
inode->i_uid and inode->i_gid on the userns-owned superblock, allowing
slave PTY device nodes to be created with unmapped host IDs such as
GLOBAL_ROOT_UID.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122011809.2667=
684-1-jarkko@kernel.org?part=3D18
