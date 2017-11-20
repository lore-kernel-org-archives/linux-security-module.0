From: mtk.manpages@gmail.com (Michael Kerrisk (man-pages))
Date: Mon, 20 Nov 2017 10:36:11 +0100
Subject: Documentation patch for namespaced file capabilities
Message-ID: <CAKgNAkiAeqbD=G6hnExh4cC84nA2mU6xdLzzS0F2x1wviEPgHg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Serge,

At the moment man-pages lacks documentation of the namespaced file
capability feature that you added with commit
8db6c34f1dbc8e06aa016a9b829b06902c3e1340. Would you be able to send a
patch describing the feature?

Presumably, the patch would be for the capabilities(7) page (or
perhaps for the user_namespaces(7) page, if that seems more
appropriate), As well as documenting the semantics, it would be good
to include an example or two of the notation that is used for the
xattr names.

Presumably also there will be some changes in userspace tools
(setcap/getcap?). Do you know anything about what's happening there?

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
