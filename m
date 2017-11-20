From: paul@paul-moore.com (Paul Moore)
Date: Mon, 20 Nov 2017 15:25:15 -0500
Subject: [PATCH] security: replace FSF address with web source in license
	notices
In-Reply-To: <20171114101053.29533-1-martink@posteo.de>
References: <20171114101053.29533-1-martink@posteo.de>
Message-ID: <CAHC9VhSVX0xYjEGAnuWYpZER=gvnjSuPn4-w9p2Cb5OOXQ5Rhw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Nov 14, 2017 at 5:10 AM, Martin Kepplinger <martink@posteo.de> wrote:
> A few years ago the FSF moved and "59 Temple Place" is wrong. Having this
> still in our source files feels old and unmaintained.
>
> Let's take the license statement serious and not confuse users.
>
> As https://www.gnu.org/licenses/gpl-howto.html suggests, we replace the
> postal address with "<http://www.gnu.org/licenses/>" in the security
> directory.
>
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
>  security/selinux/include/netlabel.h | 3 +--
>  security/selinux/netlabel.c         | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)

[NOTE: added the SELinux list to the CC line]

Looks fine to me, I'll add it to the SELinux queue for after the merge
window closes.

> diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
> index 75686d53df07..e77a5e307955 100644
> --- a/security/selinux/include/netlabel.h
> +++ b/security/selinux/include/netlabel.h
> @@ -19,8 +19,7 @@
>   * the GNU General Public License for more details.
>   *
>   * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   *
>   */
>
> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index aaba6677ee2e..2c297b995b16 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -22,8 +22,7 @@
>   * the GNU General Public License for more details.
>   *
>   * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   *
>   */
>
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
