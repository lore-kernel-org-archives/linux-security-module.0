Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422D647C101;
	Fri, 18 Sep 2026 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757819; cv=none; b=Q0dPm1iGI2hw4swnmYvcnyrYiYu4TjudFq8idTL7a+5zKjKw17i7odKDdJLI3FU5D0vfK0sAj261tMd8tEsAoNsJbCeWPvTX+3x0tpoRR3L8OX+0TFRj02wMgIfrOSBH8bqpFHMHkVHerPiiTkWNN6A9wJOxg1C3H6aD8EJ4pF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757819; c=relaxed/simple;
	bh=bUcaJf7YncuLgQBkAZXMHbXYbgJrvO5iX6BC8Th+MFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RDWCAuA7WV8fGtcokGFyYGjMWvqzsUXZ3hGPZp1FKTEtVQOIXDE5wHT7fpoPVkqpHaz56/kFQllfyz1yQ7UfjhYIKXgkHdpxg2ubPr0KpOC4mbLc9g90RyeB4EH3tTOnC42C2pa8AkcSNUZ5MxKJ9UpRHh+gda5xHhmpIYd8t3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fgb7BtFU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fgb7BtFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F5F1F000FF;
	Fri, 18 Sep 2026 18:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789757806;
	bh=bUcaJf7YncuLgQBkAZXMHbXYbgJrvO5iX6BC8Th+MFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fgb7BtFUZvLvAxeYzrfJWC0OtdewzXxz5El7hTcF/LDYzwrHCwbpwbQth2mUjhvZ5
	 krGccfHRWq2khvdsLbTqK3tlLbHDOT/fASUonBDEiqlzNbbnmPmwF9jo+kJQpd1ICs
	 L8oDz+YN32dqQKdxXA7BNtuwxO8Od36zbJBc6NpmgGaEWjViZgZhFhm79dDadNB7Nw
	 dlmq5sg+mKltgXcmSk3SPincXYnqmGpta8bbuehl3lvw7FkmBcCpkxLdtI2axBASIw
	 CpmY2uuRe9esn8EtX9mnGgoEDuKXCCbOlqbMWtBUZu+Mk93ee7zcVHy6hdeknznVC/
	 QPSoUuSmeQ8Rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/9] landlock: Report the actual ptrace tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20260918185036.608651-6-mic@digikod.net>
References: <20260918185036.608651-1-mic@digikod.net>
 <20260918185036.608651-6-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 18:56:45 +0000
Message-Id: <20260918185646.31F5F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The ptrace denial callback identifies only the tracee. Current is the
> tracer during hook_ptrace_access_check(), but it is the tracee during
> PTRACE_TRACEME, where the parent is the actual tracer. A consumer
> therefore cannot infer both parties from the existing arguments.
>=20
> Append the actual tracer task to the typed-BPF callback: current for
> hook_ptrace_access_check() and parent for hook_ptrace_traceme(). Carry
> it with the tracee domain ID in a private ptrace context. Both hooks
> keep the selected tasks alive through synchronous dispatch, so no extra
> task reference is needed.
>=20
> Keep the tracefs record unchanged. The new context is available only to
> typed BPF, while same_exec continues to describe the tracer that owns
> the denying policy.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: bb91730f16c0 ("landlock: Add tracepoints for ptrace and scope deni=
als")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918185036.6086=
51-1-mic@digikod.net?part=3D5

