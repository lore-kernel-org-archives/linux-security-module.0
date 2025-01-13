Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7361CAA6A;
	Mon, 13 Jan 2025 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779021; cv=none; b=MpeqQd8G55ExGFOhJEPA8M/u+TVX/3GxdNIyTqIdCxAXRR9gOnN3Icae+aMSXAXSP31kQnqA3dYawXCOLy8TaW2PPU+gmwp4WKZObmDSvXvxF7JH5/u7MBG1u7CWnUZXFjk2fEm1UBsVy2KLu37I2JCth8QPqUhUpVWEXu7Vl8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779021; c=relaxed/simple;
	bh=uEm7AaHSDpwzRjzu2/54yN04+VtaF1V86eu5JzbTrys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhdPJoRQKlJ3FNL6P+GD60TIfZpSDpt4sd6kS3oAwbEz9P5oA/jtVJFtE1dgloXBrdJmhCoP6HC5V0ydygII19GiFYZWxKKThad451FQmd/gx6sIescS5kmBiLxzKDnBJbpqy9orFjEqq7bGA6YyBZd5vO/aRNzPOMRjPzgwY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmT/Jlfk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmT/Jlfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D41C4CED6;
	Mon, 13 Jan 2025 14:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736779020;
	bh=uEm7AaHSDpwzRjzu2/54yN04+VtaF1V86eu5JzbTrys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gmT/JlfkgoGjMyYwfQblR29ULOXQtK8ymlViVmfurx4UuEPHBovlc7O+0Cig2tRNj
	 58LKBTtv1f4ygkYiFHqZ845hpznaCOjhIZ8mxFWqKOz1nWRgzr2EEt9qe48fqBrzcO
	 qMbnGmKG4GO8anUUy0qB0sICGvusMu6baqfV0ro2trO5ruYLdOAzAVvTDuEc0Eq+l4
	 e7xXQRvshUhSYk/f3+FolvLWDvijHgFSp5plXFurEq3HrQGGQ8sS0E/Bndrk8pvItE
	 SL+vsgQqly+pkHzwb0bMOdXrFLnU8+WLVMb4H1gq8FPo/5kKteGEYW3TcTsLOg9lWf
	 dQ+v1Gt+qLlIA==
From: Christian Brauner <brauner@kernel.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: (subset) [PATCH v4 27/30] fs: Add iput() cleanup helper
Date: Mon, 13 Jan 2025 15:36:41 +0100
Message-ID: <20250113-system-waben-2ff9c594e630@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250108154338.1129069-28-mic@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net> <20250108154338.1129069-28-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=967; i=brauner@kernel.org; h=from:subject:message-id; bh=uEm7AaHSDpwzRjzu2/54yN04+VtaF1V86eu5JzbTrys=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS3qjLq/LkUtSh3kqOVU2/cEZUwLoM+X00J6Qf7th/qW xbkv2hGRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET+fmD4n61avu/GycVRx+s5 HjnWzJx8dAZf66/fllrZd+WM7uvxmTEyLDm0e/3SX0xRHu3nko6tEFB1ZtBg33t6EpvOoVt/XYo DOAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 08 Jan 2025 16:43:35 +0100, Mickaël Salaün wrote:
> Add a simple scope-based helper to put an inode reference, similar to
> the fput() helper.
> 
> This is used in a following commit.
> 
> 

Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.misc

[27/30] fs: Add iput() cleanup helper
        https://git.kernel.org/vfs/vfs/c/38b1ff0bcff1
