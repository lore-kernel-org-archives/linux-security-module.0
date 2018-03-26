From: sargun@sargun.me (Sargun Dhillon)
Date: Mon, 26 Mar 2018 12:31:25 -0700
Subject: [PATCH] security: convert security hooks to use hlist
In-Reply-To: <alpine.LRH.2.21.1803260824560.324@namei.org>
References: <6f9d93bdf8122230ea53823a07a9d79f0c3fdafe.1521972503.git.sargun@sargun.me>
	<alpine.LRH.2.21.1803260824560.324@namei.org>
Message-ID: <CAMp4zn8SbeTYv3-Gp-AnCVu=HZa7Jg5T9YWYpHGJrbpvYydt8w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Mar 25, 2018 at 2:25 PM, James Morris <jmorris@namei.org> wrote:
> On Sun, 25 Mar 2018, Sargun Dhillon wrote:
>
>> This changes security_hook_heads to use hlist_heads instead of
>> the circular doubly-linked list heads. This should cut down
>> the size of the struct by about half.
>
> Can you please measure it?
At least for my kernel config, 1656 bytes vs. 3280 bytes.

>
>
> --
> James Morris
> <jmorris@namei.org>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
