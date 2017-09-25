From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 25 Sep 2017 13:29:11 +0200
Subject: [PATCH] apparmor: initialized returned struct aa_perms
In-Reply-To: <20170915195620.1561044-1-arnd@arndb.de>
References: <20170915195620.1561044-1-arnd@arndb.de>
Message-ID: <CAMuHMdVo3uQEiTgqpGnhEsTRYs0p0GqjucWhEuUOKPjWP78COQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 15, 2017 at 9:55 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> gcc-4.4 points out suspicious code in compute_mnt_perms, where
> the aa_perms structure is only partially initialized before getting
> returned:
>
> security/apparmor/mount.c: In function 'compute_mnt_perms':
> security/apparmor/mount.c:227: error: 'perms.prompt' is used uninitialized in this function
> security/apparmor/mount.c:227: error: 'perms.hide' is used uninitialized in this function
> security/apparmor/mount.c:227: error: 'perms.cond' is used uninitialized in this function
> security/apparmor/mount.c:227: error: 'perms.complain' is used uninitialized in this function
> security/apparmor/mount.c:227: error: 'perms.stop' is used uninitialized in this function
> security/apparmor/mount.c:227: error: 'perms.deny' is used uninitialized in this function
>
> Returning or assigning partially initialized structures is a bit tricky,
> in particular it is explicitly allowed in c99 to assign a partially
> intialized structure to another, as long as only members are read that
> have been initialized earlier. Looking at what various compilers do here,
> the version that produced the warning copied unintialized stack data,
> while newer versions (and also clang) either set the other members to
> zero or don't update the parts of the return buffer that are not modified
> in the temporary structure, but they never warn about this.
>
> In case of apparmor, it seems better to be a little safer and always
> initialize the aa_perms structure. Most users already do that, this
> changes the remaining ones, including the one instance that I got the
> warning for.
>
> Fixes: fa488437d0f9 ("apparmor: add mount mediation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
