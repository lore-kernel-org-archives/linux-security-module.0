Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792639115;
	b=KQaYd3rvRotjCGBGup9/5dbbxY5NailvSABEGjBiwQU0m7R4g8F22Jaa6KfkcxAiVJrr
	 o+oiUA+ITR8Deu6d5135kL4mJnMckmN4u6/i1XG8cj/pu1nWGmVfLLNytg6s/lM41BXO7
	 YiT9Mb+ItkMnrtnkMEuwcFMUPEqYvylhEWckc7JcYgTV/QBhMTxCrfTj5gatxJAZSIuLv
	 DyEQmZsbkzc7DFrwShUk9W/xiiqnfaW7zkLOjGRVspeY+RNwKqhqFCE8ri6XTSB+AnJoz
	 LzIGYyQmNNbietfdD/AvQzW8ECt1MmSZ7H7sPLF0ZvrTu3SVb0hjHicMDH8Dd21tmqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792639115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=a6D5xQQ5xgzdVz3zr/f0pP7qJp5HwDVkL3hDOzlNwK4=;
	b=IpEMvA7alAORSUPBiOFaDhgvIiH9CaiaPryDQ4TiiiSQ6K7EwJihXBq87Y07/9snjx1j
	 gxk2kBjQ2q/XhrrLKys6DbqCYYZssuLJq+WWc45Q33qUVZXfbqd4x/TTxb2eSfl2127Ux
	 FZj/evhCRWxeBonXWoa5VVSmJYJkewYXbjwnCi79imC6ysWmz+ICX9kq0UdNoEe57gLjS
	 Sumc96T8WL941BHlFBbZHg+dM0r5uMCayBNN9OfuCC+Jos/sACg5jIrlW4qSQhEOHXBTF
	 cBDYTGoNozJVBpVUHtc+VcPkJq/wlPHw67kWiP9zoXCtHOQg4nNfh/udficXUeQl0ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AsJwjAOO;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD4606A31A
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 03:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BFD4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AsJwjAOO
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9d7791b00so6214125ad.0
        for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 20:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792639114; x=1793243914; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a6D5xQQ5xgzdVz3zr/f0pP7qJp5HwDVkL3hDOzlNwK4=;
        b=AsJwjAOOHRgzlL1D2RSH3Gg4TIDJIApo88aNnw+ops/C71R7BWDARUKAAErQIsJdyn
         k+/xy9sEgzldd+BeQlGIUtcpjnaKsqKGNuWuLkXhTKNqC+ritg6DtviQYPFNjOUTYmP5
         f1EhjoWNljG6wWcG+8uMPOhl8by4rBhGMcpGPz7I6UfFNuT5k6tu3caNqVQmVT77LB8H
         +lqM7KXt9N4uo96kCiuhvTjolkiKbKTrZk59HMnBwKefH8AXZaPlOw21mFnNBXfLaqsB
         kOdSIcTqtslinU7xn62DtiOKUFFaO5Tl1jV3xqgBH5RfOCz3UxPobDvw90E7AAfMp6hD
         mnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792639114; x=1793243914;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a6D5xQQ5xgzdVz3zr/f0pP7qJp5HwDVkL3hDOzlNwK4=;
        b=ot83GT2Q211dtm5anmMymFdkaF6A8FvJsCfOkVU/ekjy+CDMplrHMcLBtvdww041S5
         AoA3dGIjTMvLfOrfAIX6OJDLvH7sxRxCZlZOPMM75OCOzf/Y4EMPkYsZQsQf6Zy3YnfV
         UIKGlfDu93ODRxbgEFL1FAi2ERK043XVv+cmlHUZGdDcjS162R7o2V/EF/suoUotLS7i
         K9dz/9ennjR5SWIEvBiZml3ydBIE5tE0kEm9vxAK0AGgveKxrJiHxt9nyF4rFkQqVpd1
         2qXRxwHzXSpJ3f+b8oNb3V2fp/z8D0hi4DX28YeTt5Oo9z1sXr/hOnqZI3plNOCiVpQJ
         MuRw==
X-Forwarded-Encrypted: i=1; AKwUvByf53b4zRd3abdc1lr72WiNZqDBLplZ6b03jmVJkzcTAxtV067jAE502Z3LNi5cs+gVIewYT07MSrw36hrZ5e6VZ0ANPqI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdNb8Ylre2/WZnSFtAXwuYQF1L9+L/yYNsES1oeNQIr5SagYPk
	4115vvhB5toAHBMJJpoai8cZNUZO8MlrU/Zf4X7d/bGg7P7jdNNtRse0
X-Gm-Gg: AYBFou3Yr4rBQv+J+fDq657hQhGVCbt5mCUkU/rj8i/KATEJRUFk7HzeVtGU2VjbDEI
	aPunZa1twPrW80acJE678HP8sV3TrbKWDGQ+ptg0dFReZrqQA8V8ZghLl0dLQ8NpK0n0ETi5YOQ
	0h2Xfjp6sEuUYEFLlfFifZPFHsGynXAexgXgHm9909xNl6eQ/VDtSzKSoisy4qKnD1W3myek0rP
	YfDngr9qtJcVYrs/22/oh4TVc2fSdb4pi5mpxCBHV/wdf/zfr5fanR5hBaw/IrzJiO7jiT6L3Xu
	GX+xKIdfFhtMltZ/LIpCOnm42lwPoTzKqV0lwKpoIcXtcxvVKnB9OB+x9dy6jLpKGC5QI7zcj82
	ssGOK760UPo89WRNqb7Bw4OMlnvYKxC2t93cV47Jrm69Rnl1ckkaB0guRX7pl/JJa76sPZsxC/+
	2VKSxBd3vcq4IEnoSRat9DrsUKFOjUKFO4LtxvZcjS+I3dfkvijoBgU0KJhQH8R0696SCHf6IwJ
	Rs55zlbDyTsZ549e+V41fRzdMtwFQvYH2KGYY1BOyK0n8Tuua6dT4Q/7DQGDrs03q83GBeVHEhC
	oEiSNcXkYlJF0i/5z6FHSu2xcdb5VA/30X4yZPkCxl5727EzQN1gZqFd7RDC
X-Received: by 2002:a17:902:ecc9:b0:2e9:7719:40fe with SMTP id d9443c01a7336-2ea437b0c71mr32086145ad.2.1792639114110;
        Wed, 21 Oct 2026 20:18:34 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4addfbsm17136755ad.74.2026.10.21.20.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 20:18:33 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 03:18:32 +0000
Message-Id: <DMB1J3GT728H.2KEOF9XKYSGEO@gmail.com>
Cc: <torvalds@linux-foundation.org>, <bpf@vger.kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <linux-security-module@vger.kernel.org>,
 <brauner@kernel.org>, <dwindsor@gmail.com>, <kpsingh@kernel.org>,
 <matt@bobrowski.net>
Subject: Re: [GIT PULL] BPF changes for 7.4
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>
In-Reply-To: <CAHC9VhQz1aam-P+xh8CT=3V9fNtdrcFSZ6VEOWUGx1cKWV+WYQ@mail.gmail.com>
References: <20261021210147.3450677-1-alexei.starovoitov@gmail.com> <CAHC9VhQGeZtDLKZ7iLYx-d1ua_CojCN03uSG25oVDqOm9GKFag@mail.gmail.com> <DMAVQ90EWW3Q.44GJKDHWOSFC@gmail.com> <CAHC9VhQz1aam-P+xh8CT=3V9fNtdrcFSZ6VEOWUGx1cKWV+WYQ@mail.gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 21, 2026 at 06:26 PM Paul Moore <paul@paul-moore.com> wrote:
>
> "... just as the maintenence of bpf_fs_funcs.c falls to the VFS." is
> the rest of that sentence.  We're not asking for a type of
> cross-subsystem relationship without precedent.

That file has a history.

Nov 2023. Song added bpf_get_file_xattr() for BPF LSM progs to
kernel/trace/bpf_trace.c:
commit ac9c05e0e453 ("bpf: Add kfunc bpf_get_file_xattr")

Mar 2024. Matt's v2 was adding more kfuncs for BPF LSM progs next to it.
Christian replied:
"Conditio sine qua non is that all such kfunc definitions must live in
the respective file in fs/. They won't be hidden somewhere in
kernel/bpf/."
https://lore.kernel.org/bpf/20240306-zeitumstellung-darben-7857ca9817c0@brauner/

Jul 2024. After discussions with Christian at LSFMMBPF Matt created
fs/bpf_fs_kfuncs.c in v3:
commit d08e2045ebf0 ("bpf: introduce new VFS based BPF kfuncs")
Christian acked it and asked for more:
"I also wouldn't mind follow-up patches that move the xattr bpf kfuncs
under fs/ as well."
https://lore.kernel.org/bpf/20240726-clown-geantwortet-eb29a17890c3@brauner/

Aug 2024. Song moved bpf_get_file_xattr() there:
commit fa4e5afa9758 ("bpf: Move bpf_get_file_xattr to fs/bpf_fs_kfuncs.c")
"We are putting all fs kfuncs in fs/bpf_fs_kfuncs.c."

Every xattr kfunc since then went there: bpf_get_dentry_xattr(),
bpf_{set,remove}_dentry_xattr(), bpf_cgroup_read_xattr() from Song,
bpf_sock_read_xattr() from Christian.
David's v1 in April put the new one next to them.
It cannot be in fs/ and in security/ at the same time.

> One might question the placement of some of the other BPF kfuncs
> located in bpf_fs_kfuncs.c as the file is conditionally built based on
> CONFIG_BPF_LSM as opposed to CONFIG_BPF_SYSCALL or some other generic
> BPF Kconfig knob, but there is no sense in worrying about that until
> we settle this.

Back in 2024 all kfuncs in that file were for BPF LSM progs. Matt's v2
from Mar 2024 even called the set lsm_kfunc_set_ids. They moved to fs/
anyway. Hence CONFIG_BPF_LSM.

> The lsm_get_xattr_slot() function is intended for use by LSMs
> (it's not an external LSM "hook") and the fact that the kfunc in
> question calls into it (and not a single VFS function) is one of the
> reasons why I'm arguing strongly that this is purely a LSM kfunc and
> should be located in security/bpf_lsm_funcs.c.

BPF LSM is in kernel/bpf/bpf_lsm.c since 2020 and includes lsm_hooks.h
since then. bpf_bprm_opts_set(), bpf_ima_inode_hash(), bpf_ima_file_hash()
helpers that only BPF LSM progs can call are there too.
security/bpf/hooks.c is 43 lines that register it.

I don't feel we will converge here.

Linus,
it's your call. If you think the kfunc should move I'll send a follow up.
bpf progs don't see which file a kfunc is in, so there is no need to
hold the pull request for that.
imo xattrs are VFS territory.
