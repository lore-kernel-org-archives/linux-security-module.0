From: serge@hallyn.com (Serge E. Hallyn)
Date: Wed, 29 Nov 2017 11:58:49 -0600
Subject: Documentation patch for namespaced file capabilities
In-Reply-To: <CAKgNAkiAeqbD=G6hnExh4cC84nA2mU6xdLzzS0F2x1wviEPgHg@mail.gmail.com>
References: <CAKgNAkiAeqbD=G6hnExh4cC84nA2mU6xdLzzS0F2x1wviEPgHg@mail.gmail.com>
Message-ID: <20171129175849.GC14545@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Michael Kerrisk (man-pages) (mtk.manpages at gmail.com):
> Hi Serge,
> 
> At the moment man-pages lacks documentation of the namespaced file
> capability feature that you added with commit
> 8db6c34f1dbc8e06aa016a9b829b06902c3e1340. Would you be able to send a
> patch describing the feature?

Sorry.  I'm adding this to my todo list, so I should get to it soon.

> Presumably, the patch would be for the capabilities(7) page (or
> perhaps for the user_namespaces(7) page, if that seems more
> appropriate), As well as documenting the semantics, it would be good
> to include an example or two of the notation that is used for the
> xattr names.
> 
> Presumably also there will be some changes in userspace tools
> (setcap/getcap?). Do you know anything about what's happening there?
> 
> Cheers,
> 
> Michael
> 
> 
> -- 
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
