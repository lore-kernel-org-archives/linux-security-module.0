Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CDB1A6832;
	Thu, 26 Mar 2026 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534984; cv=none; b=Cs5KT+97UDwhz+qpd4/qWEXlGkEPa6dv4lwyH22xk+FNbCTW9QC1qIMLxvF8TZhmth/0xHRMZdec9yVMwG1J61huXS3KV9yrfT0HnWVDMfkqyXxH8XloaYYcmcj2EAICeDfcvHBtU0ylmyFkhE2A5dl/IYlrbRipqerkJyzmDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534984; c=relaxed/simple;
	bh=UUwqG2nwVJ/9dy22E7iEHnBXWe5FznRUomFJAXNLPPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ut1J8tOKreSlVTnf3KuA9vu5jocRImpotvMTmLXFZvTyPGDv/ZWx5EXtZMZYDnO8Wz4au0PoAMhPdaOAFemFj0LIM+CLWO+GkMkYNMlrtJJQfzBZa/drnd7BadSFLBCfWgd8/sBOQ8UMEZY0BQEMg9CIo/y5Ns8S7oxcbPPALNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+DLU0s2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+DLU0s2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1779C4AF09;
	Thu, 26 Mar 2026 14:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774534984;
	bh=UUwqG2nwVJ/9dy22E7iEHnBXWe5FznRUomFJAXNLPPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i+DLU0s2YpZezJ+mTi1Zrml2D+DUtLyo5Xia+3odzwyPFbfJzZgk8RoZ6LaK5ZBNk
	 Tm1dOvqCuzFUq9AGgAhGua8iwmsJurw36fVVfCyqJikPmrkTsjmz4l5+gejnNPplDB
	 aJUTt0KCnlOL+mOuAQn4xW4Y12sNRM1AyRoAoFE1/F9OZkGg4To7Wpob3zSL4C2uWR
	 sdLk/lD4qTxWZcp2t4qLis/5zmE09gH8X0XqYq8VUyzrXialQp23UvA5aTABf2Ditn
	 oIfABmkghI/Mh3mozSU3FLndlcjlzQ0F4Bq1aZvI66kQ30831bFtiMXjPCaD1IN/0I
	 kC1MzyfeZkC/w==
From: Christian Brauner <brauner@kernel.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: (subset) [RFC PATCH v1 03/11] nsproxy: Add FOR_EACH_NS_TYPE() X-macro and CLONE_NS_ALL
Date: Thu, 26 Mar 2026 15:22:50 +0100
Message-ID: <20260326-sandplatz-peitschen-d802beb8275b@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260312100444.2609563-4-mic@digikod.net>
References: <20260312100444.2609563-4-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1259; i=brauner@kernel.org; h=from:subject:message-id; bh=UUwqG2nwVJ/9dy22E7iEHnBXWe5FznRUomFJAXNLPPo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQedXRcLl7eL7QicIlt3m4ftpcnmS1+BoWfiFC6fcjyq 4CdbufcjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkc/cvI0D61JEj4rpVUqYPL 1a7iWdXtclt9lc0mTTG9uddT9nhKJMM/S83TR5obdiuqiqky9B/sKb1r0hB/Nk3mUPQHZl7Bpbs 5AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 12 Mar 2026 11:04:36 +0100, Mickaël Salaün wrote:
> Introduce the FOR_EACH_NS_TYPE(X) macro as the single source of truth
> for the set of (struct type, CLONE_NEW* flag) pairs that define Linux
> namespace types.
> 
> Currently, the list of CLONE_NEW* flags is duplicated inline in
> multiple call sites and would need another copy in each new consumer.
> This makes it easy to miss one when a new namespace type is added.
> 
> [...]

Applied to the namespaces-7.1.misc branch of the vfs/vfs.git tree.
Patches in the namespaces-7.1.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: namespaces-7.1.misc

[03/11] nsproxy: Add FOR_EACH_NS_TYPE() X-macro and CLONE_NS_ALL
        https://git.kernel.org/vfs/vfs/c/935a04923ad2
