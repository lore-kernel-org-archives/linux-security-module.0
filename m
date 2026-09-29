Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82EA53FD34;
	Tue, 29 Sep 2026 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702142; cv=none; b=aiNyXbLvM9iMPdW27yo66OmfCMnLxjDHQ++JCk7kw3+W1VhZ4TN/duSgSJ2GIeAVSJWE3qZCMDc0eY9Hxq0q+5YCSxfZHeoQAM2nLNYWtWj4l8I5dZw0NjqVQuRuN9YxZe+ldgU4PykFwaWKlThL7DcKvh/DykS7KSbHJTpr77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702142; c=relaxed/simple;
	bh=U+6jp7HUaYkmEKSqLVxa3wNzkg7dPPLVoRt7HyaNihA=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=ZEv4cFFfzuGumNTvf/1wPssX5VBryKaySCM7VEfafdBDOYb4ZNaL48/2yeIxAC85NpM7+wNoheKs65dNGNpWh21bbLwF9TIsewrYz9wmbldIuhuL77K0YQQssOTYzNtKDI58C0/BoeeV7jQQB7APhouh6fQ/qjSEc1lPLkt1U88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=plmMh4UK; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=u+/poi11; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="plmMh4UK";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="u+/poi11"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790702115; bh=Iz4ApEJp1sbMYttIIcVA9H6
	I/NYlmQOeyfKY7WKGYRA=; b=plmMh4UK/tR2IcXnieDSzyFdYBJvTyQ+z8CHW3bmveAHdRo1PK
	4oIiL8Pqjzw/U7BCGxSXBKanbe43qc39fVa8DZEwONCArWcSZ/cVYEgiMNqRKoSRexUiJRsraYz
	+chN7aQJ7VoqhaWAV+jF3VADU+c2F8nGnjKVnYkbmQoyZ4iennipLoNtYmCuerI/coJUr6svZeA
	6z30ojQT0Z3O2VnOG1cS/vGXhQmlzmK8/5D9tgvJUZPRIzUIdWn+inkzCUNbGqrgVDyEb2Glxfp
	3bqvp3VvmoQrcp2q6pd//3mTm9PeNtgD9E8KzZFKlb4DFva1utvZUKMcJOYpGASfDaw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790702115; bh=Iz4ApEJp1sbMYttIIcVA9H6
	I/NYlmQOeyfKY7WKGYRA=; b=u+/poi11YFbuRB4vReyu/INIuQGdcPFdGKgEVeshKE9HQDuqSk
	yFHD1d8Dd438epGXIYeP1h262dslfDivk3Bg==;
Date: Tue, 29 Sep 2026 18:15:14 +0100
From: Bradley Morgan <brads@mainlining.org>
To: ruanjinjie@huawei.com
CC: akpm@linux-foundation.org, aleksey.oladko@virtuozzo.com,
 alexjlzheng@tencent.com, blbllhy@gmail.com, brauner@kernel.org,
 broonie@kernel.org, bsegall@google.com, bvanassche@acm.org, david@kernel.org,
 debug@rivosinc.com, dietmar.eggemann@arm.com, elver@google.com,
 jaime.saguillo@gmail.com, jannh@google.com, jmorris@namei.org,
 juri.lelli@redhat.com, kees@kernel.org, kprateek.nayak@amd.com,
 liam@infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, ljs@kernel.org,
 mgorman@suse.de, mhocko@suse.com, mingo@redhat.com, morgan@kernel.org,
 oleg@redhat.com, paul@paul-moore.com, peterz@infradead.org, pjw@kernel.org,
 rostedt@goodmis.org, rppt@kernel.org, serge@hallyn.com, shuah@kernel.org,
 surenb@google.com, tglx@kernel.org, vbabka@kernel.org,
 vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [RFC PATCH v2 1/3] capability: Move mk_kernel_cap() to header
In-Reply-To: <20260929130200.1638343-2-ruanjinjie@huawei.com>
Message-ID: <0F8FF4D1-8736-4ACB-9436-37E44517F0C3@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 29 September 2026 14:01:58 BST, Jinjie Ruan <ruanjinjie@huawei.com>
wrote:
>Move mk_kernel_cap() from capability.c to the capability header file
>so that it can be reused by other security modules.
>

Fair enoughh

Reviewed-by: Bradley Morgan <brads@mainlining.org>


>No functional change.
>
>Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>---
> include/linux/capability.h | 5 +++++
> kernel/capability.c        | 5 -----
> 2 files changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/include/linux/capability.h b/include/linux/capability.h
>index f8532d92fcad..7921a0b3b04a 100644
>--- a/include/linux/capability.h
>+++ b/include/linux/capability.h
>@@ -114,6 +114,11 @@ static inline bool cap_issubset(const kernel_cap_t a, const kernel_cap_t set)
> 	return !(a.val & ~set.val);
> }
> 
>+static inline kernel_cap_t mk_kernel_cap(u32 low, u32 high)
>+{
>+	return (kernel_cap_t) { (low | ((u64)high << 32)) & CAP_VALID_MASK };
>+}
>+
> /* Used to decide between falling back on the old suser() or fsuser(). */
> 
> static inline kernel_cap_t cap_drop_fs_set(const kernel_cap_t a)
>diff --git a/kernel/capability.c b/kernel/capability.c
>index 90e6ab62f6db..0b8ec26ead0e 100644
>--- a/kernel/capability.c
>+++ b/kernel/capability.c
>@@ -190,11 +190,6 @@ SYSCALL_DEFINE2(capget, cap_user_header_t, header, cap_user_data_t, dataptr)
> 	return 0;
> }
> 
>-static kernel_cap_t mk_kernel_cap(u32 low, u32 high)
>-{
>-	return (kernel_cap_t) { (low | ((u64)high << 32)) & CAP_VALID_MASK };
>-}
>-
> /**
>  * sys_capset - set capabilities for a process or (*) a group of processes
>  * @header: pointer to struct that contains capability version and
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
