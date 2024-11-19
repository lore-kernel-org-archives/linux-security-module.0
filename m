Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469481C1F00
	for <linux-security-module@vger.kernel.org>; Tue, 19 Nov 2024 22:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054936; cv=none; b=d9qXeFFoBEAhDh05al9R7Jkm2+m8jTSkJPpbQ2iB0hwt6tOPovEWQ38NvrSaQhRERgx1tkr5+cWU/O0u+xVJPS4WWeyGTJg25ufbGijS4+B0n4PcY+Ov57n1lMgSlc+MhuLlQq0Kbe4DD1S0yFRp2IX/l9jruUzEN6ErAPvhGGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054936; c=relaxed/simple;
	bh=3uL0FV3Jn3Ak/kkB2H583Fd3lQeYdGT3g6cqxtKkKUM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jRO6wMHK/wWwAjqeYSGgZwDfGhXWlvhBa2SEBC8GS0+qgLsl3XK8KtCZMtWaW2CJM/CYVJgWz7IngHjQXF2UwFYyxlHTryXxgwQV5F5LbuSo3lHE6RL8zB/tcsw/QbIFtZtOc7osBoIyUo8L3DMe9QYd5rsuQ7cyp6+WviyqUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDZQG2M8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDZQG2M8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4619C4CED7
	for <linux-security-module@vger.kernel.org>; Tue, 19 Nov 2024 22:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732054935;
	bh=3uL0FV3Jn3Ak/kkB2H583Fd3lQeYdGT3g6cqxtKkKUM=;
	h=From:Date:Subject:To:Cc:From;
	b=TDZQG2M8+/WK+1mshX4XXRkvXWjNdcSwxy4PiLGnFSqGwRGP+tljmEcrw7t8o7O0a
	 aSS9JvX+UOCIy04tqOZRkG516RL7O3XHRPuCK/q2vfKjBMHHIrYdtOfcXX9rTzHZPF
	 pSI+XopWJmPnIb1LhP77zQHgDdKbMVKSm8uL8Kt2eQxiKIW7DQdwPSZscztVy1UNpZ
	 OsgFpah0J8fg8rZdqGsoNCZqzVnwbt2YVnquJ5oilHW9wdr4Z3sky7vA+6qcdx0gki
	 gaOTj4VaQKVDfaO4hKN5t5qAOuuyfs1frAQ4s3qkvrnne+X0i9jRktSi0BXbX0USnn
	 2I/qnW07qWeNQ==
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e388d8850d3so1531917276.3
        for <linux-security-module@vger.kernel.org>; Tue, 19 Nov 2024 14:22:15 -0800 (PST)
X-Gm-Message-State: AOJu0YzUv/hUG5S/grF8iJV5Id4filFyra/CiRcWqz3Pg13r1EPHefVQ
	GmRa5nMkE5JQXM/9rO1UUT14BVSsVKANKWdHeP4bBwhGJGdjn73fse2UnTKySoI7dwmT1esHL2W
	afFKC7GCw/0Rb9r4Uwzpu8I6zQqQ=
X-Google-Smtp-Source: AGHT+IHwwU91OzBrNff7Ij7EGeZ2f9e07cujhegxnOZtpFodeWC87PEUU+tjTO3rfrvGbsy4qtapithIktjDdSREeyg=
X-Received: by 2002:a05:6902:2110:b0:e30:6dea:3ab4 with SMTP id
 3f1490d57ef6-e38cb58cfe0mr423813276.23.1732054935191; Tue, 19 Nov 2024
 14:22:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fan Wu <wufan@kernel.org>
Date: Tue, 19 Nov 2024 14:22:04 -0800
X-Gmail-Original-Message-ID: <CAKtyLkEwKogdje+Wo_ZH2W+sUA2+E6H1J0gMQ0TEyAfxWigLmA@mail.gmail.com>
Message-ID: <CAKtyLkEwKogdje+Wo_ZH2W+sUA2+E6H1J0gMQ0TEyAfxWigLmA@mail.gmail.com>
Subject: [GIT PULL] IPE update for 6.13
To: torvalds@linux-foundation.org
Cc: linux-security-module@vger.kernel.org, 
	Colin Ian King <colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please merge this PR for the IPE update for 6.13.

This PR contains only one commit from Colin Ian King, which removes
unnecessary error-handling code in the IPE boot policy generation
helper program.

This commit has been tested for several weeks in linux-next without any issues.

Thanks,
Fan

--

The following changes since commit adc218676eef25575469234709c2d87185ca223a:

  Linux 6.12 (2024-11-17 14:15:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git
tags/ipe-pr-20241119

for you to fetch changes up to 9080d11a6c5c1fbf27127afdef84d8dcd65b91ff:

  scripts: ipe: polgen: remove redundant close and error exit path
(2024-11-19 13:57:03 -0800)

----------------------------------------------------------------
ipe/stable-6.13 PR 20241119

----------------------------------------------------------------
Colin Ian King (1):
      scripts: ipe: polgen: remove redundant close and error exit path

 scripts/ipe/polgen/polgen.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)
