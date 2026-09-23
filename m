Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E45563FBF;
	Wed, 23 Sep 2026 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190718; cv=none; b=qwTMX9WNThe78w0wMMFReaa+kHVVlt1PUSmqxDqB4kUszFT3r3yJa6Fv3NKuHM/Cs2D+0qjnJdQkTkbpCC2LlVXKsatPhUwvf95AX8lnVu2jNEVw/B3s4LeP4OKCXWDNGYy6izkET/sQtU08oFZRxw0m3qC9zJMAdf0xKbACi64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190718; c=relaxed/simple;
	bh=9wNnJWqpX2HCqVGYevz7wE4LRB1ObhaQEt3drGqu1jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHAzGHKeRIXHY62nSt8T3WiesyR6r0XFxeKtk5COk0UDUSRF+cXCXaXi6MlRN6highmstCn3bvRpl0qA5Kr/dmCIjHTJsay4aQOmHhwDvyZfQ/YiN1AefpoajWWPRdVa2F6rH5x8Y+R8iMZz+z2EiiCPQdvs/BzowfxggyFov9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=KbQ2imc9; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="KbQ2imc9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XjVnJQ+Ibmtg1jWcz4XfALtNL+ZLsNxZ+9JRPfOwmtU=; b=KbQ2imc9gCAmye0lgdQYOrjpcA
	VicQXigXIC+MrobS+RzonJsvdoKeldapjqVXHiA+rNuinAuEWHlY/Mo+aPgkW2dKWlX8JXaF2o5oJ
	rNsHMRmyYWbAQ8UiZq9pApVPbIkP+kT5fP4Y++Rh7vJnkUeROq8EUMurp8u/AYvemZrM5cOgoXDrm
	1B6K94cH8Ucpwyv+wU1DPJaOGUF/HVDsEul28VzXxihkaTbQtaHss3G0D+pd6AZ/RqOi5WOp/bAT2
	Q/5P6ABSlMftDlSfpmhiaJXP30/dHfFxpRYH0PTSkUXE1CMPqCNbcd8IrGIS3adoB5xgwoyUYQVSk
	2RpbSM6g==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x9SNe-000NYW-2C;
	Wed, 23 Sep 2026 21:11:46 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1x9SN6-0008y1-0Z;
	Wed, 23 Sep 2026 21:11:45 +0200
Message-ID: <04fe4568-90cb-4aac-a21d-c0443e418b46@iogearbox.net>
Date: Wed, 23 Sep 2026 21:11:44 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at
 inode creation
To: Paul Moore <paul@paul-moore.com>, dwindsor@gmail.com
Cc: alexei.starovoitov@gmail.com, brauner@kernel.org,
 john.fastabend@gmail.com, memxor@gmail.com, kpsingh@kernel.org,
 matt@bobrowski.net, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260915150739.284189-1-daniel@iogearbox.net>
 <20260915150739.284189-5-daniel@iogearbox.net>
 <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28132/Wed Sep 23 08:24:42 2026)

On 9/23/26 6:57 PM, Paul Moore wrote:
> On Tue, Sep 15, 2026 at 11:07 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> From: David Windsor <dwindsor@gmail.com>
>>
>> Many in-kernel LSMs (SELinux, Smack, IMA) store security labels in extended
>> attributes. For these LSMs, atomic labeling during inode creation is
>> critical: if the inode becomes accessible before its xattr is set, it is
>> briefly unlabeled, which can disrupt LSMs making policy decisions based
>> on file labels. Existing LSMs solve this by setting xattrs in the
>> inode_init_security hook, which runs before the inode becomes accessible.
>> BPF LSM programs currently lack this capability because the hook uses an
>> output parameter (xattr_count) that BPF programs cannot write to, and
>> existing kfuncs like bpf_set_dentry_xattr() require a dentry that isn't
>> available until after the inode is accessible.
>>
>> Add a bpf_inode_init_xattr() kfunc that takes the hook's own xattrs and
>> xattr_count arguments, passed through from the program's context, and
>> claims a slot via lsm_get_xattr_slot() on the program's behalf. The
>> xattr_count output argument is exposed to inode_init_security programs
>> as trusted read-only memory, so programs can pass it to the kfunc but
>> cannot modify the count themselves.
>>
>> Reserve BPF_LSM_INODE_INIT_XATTRS slots in bpf_lsm_blob_sizes the way
>> every other xattr-providing LSM does, for the life of the kernel. The
>> framework keys the collection off the reserved slot count, so a kernel
>> built with CONFIG_BPF_LSM=y now allocates the xattr array on every inode
>> creation, whether or not a program sits on the hook.
>>
>> Give the hook a strong prototype in bpf_lsm_proto.c so that its qstr and
>> xattrs arguments are marked __nullable. Both can be NULL for some callers.
>> Without the annotation the verifier otherwise hands the program a trusted
>> non-NULL pointer which it dereferences. Also, keep the hook out of the
>> sleepable set. inode_init_security runs inside the transaction creating
>> the inode, with a journal handle held on ext4 and btrfs and the parent's
>> i_rwsem down, which is why everything on the path allocates GFP_NOFS.
>>
>> Signed-off-by: David Windsor <dwindsor@gmail.com>
>> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   fs/bpf_fs_kfuncs.c         | 99 ++++++++++++++++++++++++++++++++++++++
>>   include/linux/bpf_lsm.h    | 11 ++++-
>>   kernel/bpf/bpf_lsm.c       | 22 ++++++++-
>>   kernel/bpf/bpf_lsm_proto.c | 15 ++++++
>>   security/bpf/hooks.c       |  1 +
>>   5 files changed, 145 insertions(+), 3 deletions(-)
> 
> @Daniel, you were CC'd on David's previous patches, so I'm guessing
> you saw my objection[1], but just in case you hadn't please look at my
> comments where I requested that David's proposed LSM kfunc be located
> in security/bpf_lsm_kfuncs.c as opposed to fs/bpf_fs_kfuncs.c.  It
> would be really nice if we could sort this out now and avoid having
> this drag out or escalate.

Paul, I reached out to David recently asking whether I could offer some
help with the BPF bits, added some bug fixes and a lot more BPF selftests
as I think the inode xattr init is valuable work and something we need as
well. I just reread this whole thread below given its quite a while back
and didn't follow in too much detail back then.. the location as it is is
perfectly fine, I see no reason to change it, and I guess that makes three
of us then including the VFS folks [0]. In that file there are a number of
other kfuncs as well already related to xattr in context of dentry, files,
etc. I don't see a point at all on endless bike shedding on this, its
perfectly reasonably where this is located. In case you have some technical
comment or found a bug, let me know, happy to address.

   [0] https://lore.kernel.org/bpf/20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner/

> @David, simply for my own understanding, did you ask Daniel to do
> this, or was Daniel operating on his own with this patchset?
> 
> [1] https://lore.kernel.org/linux-security-module/CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com/
> 

