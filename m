From: keescook@google.com (Kees Cook)
Date: Fri, 28 Apr 2017 13:24:36 -0700
Subject: converting Documentation/security/* to .rst
Message-ID: <CAGXu5j+YuXd70ZCNBJRfQNXwMqSPgVaqEyaq_yXkbgje3-gdVg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

I was curious if the conversion of security/ (and prctl/ which only
has two files that should probably both be moved to security/) was
already on someone's TODO list? I'd love to get these done (I refer
people regularly to seccomp_filter.txt and self-protection.txt), but I
didn't want to duplicate any efforts.

I read about various tools to help with auto-converting files to kind
of help speed up the process, but I couldn't find what seemed a
canonical answer to what to use as a helper. Is there one? (Perhaps
this was only for DocBook?)

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
