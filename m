Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976E18643;
	Sat, 27 Jul 2024 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722112383; cv=none; b=EPFmAxuV2ieU0JjSuBL0dB+TtDPRSYTdScpvID30FdfA2If7rr7OBRWxGG9rZdamZMYuYh2VqxAunUHf6n25BI3YnxQTsXUYhFQq5XaZkijDeE6twfMUgbdBm18NyYUE8sidtAs3/MSOqr8XJffzL8xICoHpFYtCbR8CGpJKwEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722112383; c=relaxed/simple;
	bh=DpSgpkZvuLUZVNBT3Vb4mqU32qmMylafuoxwCOAiLVA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GqcLnqaWBaMS4YkKAi2gVe3fI5QmSPXrQrYUlyVPseybfKIQrA5usrrzNWS+k1pz7gRTGoAGhBPH2aBNhYqQUPBc/oFev1zoH+pK4aNx9NJRtG72julPEvw2L8DQ397gSuNSXFYWdAfRN0BTVQWfa8RIJ16Y/QKaAHTMsrPEpM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAeiVayM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAeiVayM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 049F9C32781;
	Sat, 27 Jul 2024 20:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722112383;
	bh=DpSgpkZvuLUZVNBT3Vb4mqU32qmMylafuoxwCOAiLVA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EAeiVayMuM9B5vjkfvNrJuZ7GWZxlUw71s4yjVIMZxrWWQYz9f24HMV6YF1IHSqrN
	 CJ9jrR+6xaD4H1DffCCXExLrR+e8HINZ9TFWN/69bPNRqJTSTQ2T8jEzAtYqM9jtZZ
	 F/ZvY7UoOuur6CiMmpPoYsFFIiOSweyDGlqEs85VyKfc7xONfrCqDmnhOuWkbDYg3w
	 VVJ2C4h13st2+CbvQl5MkFstSEDVdck3rTxy/RYNUbDzzEBXu5jcnypcwx9VsBV4XV
	 XOmZReuu04N1CFvB5nkUXlTdYMdK+HN2G8llle9iqcmqc3zvtff+u2F6n6SQT7cAHF
	 /x9KZR4tSnu3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBD4DC43601;
	Sat, 27 Jul 2024 20:33:02 +0000 (UTC)
Subject: Re: [GIT PULL] AppArmor updates for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <d6585289-6146-4a10-bbdc-7bdfa5b16ffb@canonical.com>
References: <d6585289-6146-4a10-bbdc-7bdfa5b16ffb@canonical.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d6585289-6146-4a10-bbdc-7bdfa5b16ffb@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2024-07-25
X-PR-Tracked-Commit-Id: e0ff0cff1f6cdce0aa596aac04129893201c4162
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff30564411ffdcee49d579cb15eb13185a36e253
Message-Id: <172211238295.32007.614550602116166247.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jul 2024 20:33:02 +0000
To: John Johansen <john.johansen@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKLM <linux-kernel@vger.kernel.org>, "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Jul 2024 11:06:28 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2024-07-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff30564411ffdcee49d579cb15eb13185a36e253

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
