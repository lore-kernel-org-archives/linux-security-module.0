Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC69E27AC45;
	Tue, 26 May 2026 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795360; cv=none; b=PE7V+oNH+EdBwOgpjvRHxtGIuvan4k7f2m5uqjnWkOHlkPyS2lRNhgg339CaB0EGXjUSV+ijmkqEoUJMCgkbCRgaG43Av/mMfvA1kPk75hn+WYHMCXhReRiGJMRfkY7lTKUpVZBPw1VEWmd+P0hTry5w3mmuNu2opmPe+CZcTb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795360; c=relaxed/simple;
	bh=HO2dMnPwk7LD1hzmaJr/Eo9RHeir7zm5koQqCs1AjVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paggrHMu7JAiO2Ebdi6HpZ1HUf+6iYIHaqfNs/vj35zFH2Rr1XxGH6uIOxZPuji4T/N6EOzU22wpOBj66dq4Nij3QeNu6yexqe4Kqx5Onm7ykHR1DVYFec8F0ewVGcOyJWzZqWN0HFIRRuh7/6hez6xg9tvWJ/WE/3b6LOAD8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=aBKvmuQZ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="aBKvmuQZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1779795351;
	bh=HO2dMnPwk7LD1hzmaJr/Eo9RHeir7zm5koQqCs1AjVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBKvmuQZTp6ZKtR7ynKixoXE7f2WMAle0qcJl9B/WSVwC3AiAFcf6xmu8VQ93nDVm
	 06ZJKxHeEK5WnQDXtpIecpLL231TRGxoWz8jum8/5wkSJPQPszeMFItOggbcmV30p5
	 izm/ufOZTR+xqoMmUXPxmtOuxymwa4WTfcoECq2I=
Date: Tue, 26 May 2026 13:35:51 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>, 
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>, 
	Christian Heusel <christian@heusel.eu>, =?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: [PATCH v5 06/14] module: Switch load_info::len to size_t
Message-ID: <a1be99b5-997c-44d7-9516-5a53238034b7@t-8ch.de>
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
 <20260505-module-hashes-v5-6-e174a5a49fce@weissschuh.net>
 <8de0e6ad-987a-4729-bbd0-8399968dbb48@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8de0e6ad-987a-4729-bbd0-8399968dbb48@suse.com>

On 2026-05-26 11:47:09+0200, Petr Pavlu wrote:
> On 5/5/26 11:05 AM, Thomas Weißschuh wrote:
> > Switching the types will make some later changes cleaner.
> 
> Since the updated version drops the patch "module: Deduplicate signature
> extraction", I believe this change is no longer necessary.

Ack.

(...)

Thomas
