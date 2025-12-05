Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBAD1991B6;
	Fri,  5 Dec 2025 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764894983; cv=none; b=Z3T/RQaxgQnCR8xzrFObyfCJabB04kWRXFLotwMLu0Yzo3LKPxFNytg20Ph4UktNT9YQ3/EDr+lCR/SGD8uivuXljxgfDsqmOOQ0cxFWaLTvnYbnr3781aGamWFdq8yT+Y+bP0DrZaZnhgpIkod4kqA98kYTwHJxpKqSGNa5/hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764894983; c=relaxed/simple;
	bh=k3+zfW54MMfobNMM6D4odQFIftN3/WED9pnlB3QtN5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lnUmUr+HI78vl2DbWYfkB3KztqmsT5eJevtdka0y8Z1BV8QIWUI2yawNmk1ACYB4xx0DGdW7isd4cG9LRGuLhYcNVSayS4C9JL0WpPZ3gfRDeP58sbqfb81uJ/IrAcRsBglfzSJf7WEuCTVJDBUo7yRaO8TVuEhB3FCtvI9+GQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id E01146FA; Thu,  4 Dec 2025 18:27:22 -0600 (CST)
Date: Thu, 4 Dec 2025 18:27:22 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Ryan Foster <foster.ryan.r@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [GIT PULL] capabilities update for v6.19
Message-ID: <aTIm6grHZUhRncFH@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

This contains the capabilities changes for 6.19.  There is only a single commit,

   Clarify the rootid_owns_currentns

which introduces no functional change.  Ryan Foster had sent a patch
to add testing of the security/commoncap.c:rootid_owns_currentns()
function.  The patch pointed out that this function was not as clear
as it should be.

This commit has two purposes:

1. Clarify the intent of the function in the name
2. Split the function so that the base functionality is easier
   to test from a kunit test.

This commit has been in linux-next since November 18 with no reported
issues.  Ryan has posted an updated test patch based on this commit.

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-pr-20251204

for you to fetch changes up to 9891d2f79a9fe9b77ad290f950eb8fa3e375330e:

  Clarify the rootid_owns_currentns (2025-11-18 18:00:19 -0600)

----------------------------------------------------------------
Capabilities patch for v6.19

There is only a single commit,

   Clarify the rootid_owns_currentns

which introduces no functional change.  Ryan Foster had sent a patch
to add testing of the security/commoncap.c:rootid_owns_currentns()
function.  The patch pointed out that this function was not as clear
as it should be.

This commit has two purposes:

1. Clarify the intent of the function in the name
2. Split the function so that the base functionality is easier
   to test from a kunit test.

This commit has been in linux-next since November 18 with no reported
issues.  Ryan has posted an updated test patch based on this commit.

----------------------------------------------------------------
Serge Hallyn (1):
      Clarify the rootid_owns_currentns

 security/commoncap.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

