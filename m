Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614146;
	b=EvO9NJd1mdcgbSZSgkuVEUbN5Wz1QVrUBWbJOdbO47LLt/tvV56+Ex07BAkkmuMkefEn
	 eti3k5TPzhPpHX1Bfpoe+wx/0wDe+csN1HNlxv6Tgwrg4Qoa6keP2ue/XQLj3rL8TaBS6
	 sUxZ55qPVdayfSfxc+iRbFgvewcDJZHlH7LqeKMof8Emo08LL/T+2oBU9lXbHTGXvvu4V
	 HfvretxMXrNGBuA8uHw0s7G/p8pvNV2B9I06rXaSpQpc0Ke0iDSP/fiPSNQqbkUXumK90
	 YQXLIfZo6ic+0AgVURnIUYPXigGiBmi3WsnL8BsWlN7OSMje1kENcUsuD7DQiRoZ/+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614146;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=/wHlDXhGpogQsiezmZhcDfowx6jzRaWm0ETUcfvu/zw=;
	b=EY7WH50leJnjiQJJAKI+ux3n1eQehqmxIU3ZMeVrOiEUXviuMMv3oknLONW3nl3hEa51
	 FQw9Hjl9gE8gyRMZaGdBA8g+r3hqHWpMch4S4HQaweVqKIWcj9pLH2nVtW7CdLro+vYUB
	 tPPQOEaaX4JR+PW9cN1oZYAx3FXfazEa6mcX+fvfSgas+PDWRjNSVmQzWNaweVkeRpuYn
	 TAtA803LfdfedqtmmKC62nwy+NZMrwTNS9JOYJNnITqJSsaeH+N+Kk2i63XpLGFqLYcem
	 fRKJcbR8a6mfRIQ8+m7Vf7obOrYVFzQB06zyJC1lDNpq5TP8hhOjZXTGDeX//a5bWHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WrgcfJ4/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9075606A882;
	Fri, 13 Nov 2026 23:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrgcfJ4/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D867B1F000C4;
	Fri, 13 Nov 2026 23:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794614145;
	bh=/wHlDXhGpogQsiezmZhcDfowx6jzRaWm0ETUcfvu/zw=;
	h=Date:From:To:Cc:Subject;
	b=WrgcfJ4/B9LvqbnXF3HQ2VVvoyCVurvOKnY6FMGUYurW3tIZY7/H00/zGNk+icrdZ
	 LJ0Pn+ykF4Gk6KVzg6AeQcsSC9hVsdyb8WbiVgfkO1+TbhMLp6lnuqILNVtK0ZdkpG
	 FMCmd3hC8pWJtbtWAfP6iBwvwTjDRo9sNiy/4VSeBLUf9H3+wQdD4L5jbOzViOmJe/
	 NcjSJOl4rlnZuingLq6ZvIOQKbPqXEg5mw9HmW3AKffNpQMVpbHQCh2npXLUje5Jxb
	 1iYuktw2lzBAESupZvK7rux5V+UtmCKKraDgHTmbVEqf7D3qzzu7nSCl4jYU6VcNz2
	 z50UMOMwSz9/Q==
Date: Sat, 14 Nov 2026 00:55:40 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ima/evm: security.ima and security.evm get written to frozen
 filesystems
Message-ID: <20261114-erstmal-vererben-leibhaftig-63db6f0c66ba@brauner>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hey,

I'm working on some freeze protection fixes that plague the tree.
IMA and EVM update security.ima and security.evm without freeze
protection. IOW, they modify filesystems that are frozen. On ext4 that
trips the WARN_ON() in ext4_journal_check_start().

The update on the last close:

__fput()
-> security_file_release()
   -> ima_file_free()
      -> ima_check_last_writer()                  # iint->mutex
         -> ima_update_xattr()                    # inode lock
            -> ima_fix_xattr()
               -> __vfs_setxattr_noperm(security.ima)
                  -> evm_inode_post_setxattr()
                     -> evm_update_evmxattr()

Nothing on that path holds sb_writers. Write to a file covered by an
appraise policy, freeze the filesystem, close the file.

The same happens when files are appraised:

- fix mode: ima_appraise_measurement() -> ima_fix_xattr() and
  evm_fix_hmac()
- evm_verify_hmac() converting a digsig into an HMAC

for open, exec, mmap and kernel_read_file(). Only an O_TRUNC open of an
existing file holds sb_writers there.

Reproducer on v7.4-rc1, booted with ima_appraise=fix, ext4 on /dev/vdb:

    mount /dev/vdb /mnt
    echo "appraise fsuuid=$(blkid -s UUID -o value /dev/vdb)" > /sys/kernel/security/ima/policy
    echo a > /mnt/f; sync
    exec 3>>/mnt/f; echo b >&3
    fsfreeze -f /mnt
    exec 3>&-

The close rewrites security.ima on the frozen filesystem:

  WARNING: fs/ext4/ext4_jbd2.c:90 at ext4_journal_check_start+0x1f6/0x2d0, CPU#0: bash/280
  Call Trace:
   __ext4_journal_start_sb+0x7a/0x470
   ext4_xattr_set+0x20d/0x380
   __vfs_setxattr+0x10f/0x170
   __vfs_setxattr_noperm+0xf4/0x5e0
   ima_update_xattr+0x1bb/0x2a0
   ima_file_free+0x2a7/0x3c0
   security_file_release+0x55/0x60
   __fput+0x2d6/0xab0
   fput_close_sync+0xf2/0x1c0
   filp_close_sync+0x5c/0x90
   __x64_sys_close+0x71/0xe0
   do_syscall_64+0x10e/0x5e0

Removing security.ima from a file and opening it while frozen does the
same from the appraisal:

   __vfs_setxattr_noperm+0xf4/0x5e0
   ima_appraise_measurement+0x2d2/0x36a0
   process_measurement+0x15b8/0x2120
   ima_file_check+0xbc/0x110
   security_file_post_open+0x3f/0x90
   path_openat+0x4ab/0x2300

I don't think this has a trivial fix. iint->mutex nests inside
sb_writers: do_open() holds mnt_want_write() for O_TRUNC across
security_file_post_open() -> ima_file_check() -> process_measurement().

So taking sb_start_write() under iint->mutex or under the inode lock
inverts the order and deadlocks against a pending freeze:

- close holds iint->mutex and waits in sb_start_write()
- an O_TRUNC open holds sb_writers and waits for iint->mutex
- the freezer waits for the open

Skipping the update while frozen isn't great either.
ima_check_last_writer() has already cleared IMA_UPDATE_XATTR by then and
nothing redoes the update, so the next open in enforce mode fails with
-EACCES on the stale hash.

For close the only thing I see is taking sb_start_write() before
iint->mutex when an update may be needed. That makes close() block
while the filesystem is frozen, which xfs_file_release() goes out of
its way to avoid.

The appraisal-time fixups can use sb_start_write_trylock() and skip when
frozen since they're best effort anyway.

This goes back to 2fe5d6def167 ("ima: integrity appraisal extension").
