Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0FE25B08D
	for <linux-security-module@vger.kernel.org>; Sat, 10 Oct 2026 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791628372; cv=none; b=NfnvKhQv5N8KI1LvY7RW/scoAA5zB6StH+mdHuBjnihAO8pzuu/wmNmhU1c/BMTOqagakt1yLVuH610pNshWObY/THg336g/gvnAht0vUlT74y2wKmfDotfPFMqtzP4FjXMvMvzwqqV6f/1vhbCk6OGrpeNjfRp2DsXaQpCEHqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791628372; c=relaxed/simple;
	bh=VQcLOqfKz7qjXhvq2JtKFlj0e8n2bZYv3nYVGXKYduA=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=abgN4h4Xrb/62O8Mi+ViyIGUeNYrjPitUcfLmLYRCTOPuuA7zhKhrSstC3W1/vX1dQCqqdQhNI7IMtHN+2sXlDMLICb8fLjTmwRSKrUVtdk+9YcbQAu535LaY7k0+EMNraGKhIBuJp5LWK1bZ29d4uH9dqN0HgXIiuUrxQ48R6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNYyW0yE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNYyW0yE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0C41F000FF
	for <linux-security-module@vger.kernel.org>; Sat, 10 Oct 2026 10:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791628370;
	bh=VQcLOqfKz7qjXhvq2JtKFlj0e8n2bZYv3nYVGXKYduA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=TNYyW0yEpVEF5SMWQEDQbaEmblIf4IJkPV+pePcsQSOyc3TlzAFOwYxCuXK7d89Yj
	 YfV3AgVLkBRUaornZQmJ+EuM6gbpnZp6Tja2c/N9PGTIPU0/+d9baAq7OKXEf2GeNh
	 4X3/RPU/sgrkZDlMDbzB8hDDDMPdBoAhaGp/OsyceMaZWOpe/g9G8g3FeD9HGLbRYr
	 BqkzH4PppdL8GnjKHkaU/6K3d+DAwfYE7BoWVZ3K4h3jukuNEITan+9UnFW0zU8bEA
	 dCOkZqBlvTvnWC+ncYKrhGAVbnsDrlwQL6QRYDlo3eQ5MNVkXuatSw/104M88k+RVz
	 4U3oXIa82ZEYA==
Message-ID: <sashiko-outbox-166438@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] pidfd: Add task path ioctls
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261010-pidfd-get-paths-v3-4-f245440b2b30@black-desk.cn>
References: <20261010-pidfd-get-paths-v3-0-f245440b2b30@black-desk.cn>
 <20261010-pidfd-get-paths-v3-4-f245440b2b30@black-desk.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 10:32:49 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Chen Linxuan <me@black-desk.cn>
>=20
> Add PIDFD_GET_EXE, PIDFD_GET_CWD, and PIDFD_GET_ROOT to return
> close-on-exec O_PATH file descriptors referencing the target task's
> executable, working directory, and root directory.
>=20
> The ioctls acquire the target through the shared task acquisition
> helper and are thus subject to the same checks as the namespace
> ioctls. The target is sampled while holding exec_update_lock so that
> the access check and the path read cannot race with execve().
>=20
> This allows userspace to obtain stable path references from a pidfd
> without requiring procfs.
>=20
> Assisted-by: LLM
> Signed-off-by: Chen Linxuan <me@black-desk.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010-pidfd-get-=
paths-v3-0-f245440b2b30@black-desk.cn?part=3D4

