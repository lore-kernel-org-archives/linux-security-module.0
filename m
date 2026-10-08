Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B2A4A43F0
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469952; cv=none; b=oTpRebR7K+YzXMjg1IQlpurvR6HM4IuJY4k1OEMbMMRwsRqEEyfMj+9MgTISa+qug3ZFGtqn0s1FG07KZc3Pqk5AZnWJCprgXJ5wMcX7wuJL3B3bKCnt6EpE9dneQbRKkrk+M00dpD+a39Sl0rAomTbfbviObRVLL6wg6P0htu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469952; c=relaxed/simple;
	bh=M+/cT78gALhyyWswJFPMQPwGPwzRobTgs7dQ/K16t90=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PhUzLWxK+LPD/1sp5VtHwnMlX65PWsWiSN/Lzi4rIwJ/9kqvqqsa9+b/bCoij+zOpyNp7o36sd87vTa0OHlNPzfIxWQNLX63oXyKxoThWQa7DL/wM1vuV/QYNAW3iXesIrITNNiFbZL2tD4iLd4EyXBxx+WUPmrs8wBFnphdGAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RE36Fy8y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RE36Fy8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FB71F00893
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791469950;
	bh=M+/cT78gALhyyWswJFPMQPwGPwzRobTgs7dQ/K16t90=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=RE36Fy8yI6IiWGW4zZvC6aEnuf5pS2KSM+BGT5Hx5JmsiyNup7ncthm5tQyxjJhxL
	 +SHgmfyDhnMT0mj6Q5FVHJe5HN9y2Yct07/dm3ZiMoRbSWefoLvhFJPfU3wQ+KhOhi
	 dU5sTY/IrfdcOJUEDUOo+zJEXvkx50nIT/R364NpWtEirwt0kz/SMTHvni/3bNOCV9
	 Z98xP5kfUkGtJVyjtApzXG5YYAFyEl3VHKKf/YOgIIKuyPB3PAHOr7k63JSF0A9gEb
	 AzucR/dKFuh1QjjObxlfro212ugboD7qsdYBM7uoVs0D+sQ5rpimLe2x6YEbt81x9/
	 bEg1uGWmsRcLA==
Message-ID: <sashiko-outbox-164289@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/27] selftests/landlock: Close leaked file descriptors
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-17-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-17-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:32:30 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Several tests do not close file descriptors they open: the /dev/null FD
> in restrict_self_fd and restrict_self_fd_flags, and the parent's ends
> of the synchronization pipes in various ptrace, audit, signal and
> abstract UNIX socket tests.
>=20
> Close them once they are not needed anymore.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D15

