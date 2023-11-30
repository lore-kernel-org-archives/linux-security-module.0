Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="h7IIHhg1"
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4721A6
	for <linux-security-module@vger.kernel.org>; Thu, 30 Nov 2023 01:30:47 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SgrXQ0sZRzMqSxl;
	Thu, 30 Nov 2023 09:30:46 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4SgrXP1q5Rz3g;
	Thu, 30 Nov 2023 10:30:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1701336646;
	bh=jCjvPr/6h0MOipCt2pUCTUTvAIXA4IKCWKEbGBr9Asw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7IIHhg1ayxw7rC+w1OGSWTUStSS6kJc0fO+6sh6MXkTUIVo6aCZzmpDXY3gWXB3L
	 uzIgUXVnaO39YUX8hCxZwhpgpDKMzmoYfD0E3LsRjfxbXedXRZRaZOCEhEpoTAInOJ
	 0/YV4RO47DjQRCTKjt0v9VtGw0W0zP0OGNDC/5+s=
Date: Thu, 30 Nov 2023 10:30:43 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 5/9] selftests/landlock: Test IOCTL support
Message-ID: <20231128.Zei2voh9iuro@digikod.net>
References: <20231124173026.3257122-1-gnoack@google.com>
 <20231124173026.3257122-6-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231124173026.3257122-6-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Fri, Nov 24, 2023 at 06:30:22PM +0100, Günther Noack wrote:
> Exercises Landlock's IOCTL feature in different combinations of
> handling and permitting the rights LANDLOCK_ACCESS_FS_IOCTL,
> LANDLOCK_ACCESS_FS_READ_FILE, LANDLOCK_ACCESS_FS_WRITE_FILE and
> LANDLOCK_ACCESS_FS_READ_DIR, and in different combinations of using
> files and directories.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 431 ++++++++++++++++++++-
>  1 file changed, 428 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 0e86c14e7bb6..94f54a61e508 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -9,6 +9,7 @@
>  
>  #define _GNU_SOURCE
>  #include <fcntl.h>
> +#include <linux/fs.h>
>  #include <linux/landlock.h>
>  #include <linux/magic.h>
>  #include <sched.h>
> @@ -672,6 +673,9 @@ static int create_ruleset(struct __test_metadata *const _metadata,
>  	}
>  
>  	for (i = 0; rules[i].path; i++) {
> +		if (!rules[i].access)
> +			continue;

I hope this change will not hide some bugs in future changes. We could
set .path to NULL instead but I think your approach is OK.

> +
>  		add_path_beneath(_metadata, ruleset_fd, rules[i].access,
>  				 rules[i].path);
>  	}
