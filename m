From: keescook@chromium.org (Kees Cook)
Date: Wed, 5 Sep 2018 10:13:27 -0700
Subject: WARNING in apparmor_secid_to_secctx
In-Reply-To: <CACT4Y+ZVHit9C-w78mEUEtpZjyncaR_3S5fu_KZk2YuBtthK9w@mail.gmail.com>
References: <000000000000c178e305749daba4@google.com>
	<CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
	<1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov>
	<5806108.mdyebWjNCB@liv>
	<CACT4Y+ZVHit9C-w78mEUEtpZjyncaR_3S5fu_KZk2YuBtthK9w@mail.gmail.com>
Message-ID: <CAGXu5j+OhEFJQJTiip5AmL2PYgBZwwL7vaRCFjSaFOXhwJnx0Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 4, 2018 at 7:53 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> Again, if you change wheezy to stretch here, it should reproduce the problem:
> https://github.com/google/syzkaller/blob/master/tools/create-image.sh

FWIW, I sent an update for the image version here:
https://github.com/google/syzkaller/pull/708

-Kees

-- 
Kees Cook
Pixel Security
