import 'blog.dart';

final uuid = UUID();
final createdBlogs = [
  Blog(
      uuid: uuid.generate(),
      title: "Test blog 2!!!",
      createdDate: DateTime.now().subtract(const Duration(days: 1)),
      blogContent: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    // imageData: "/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJ8AzgMBIgACEQEDEQH/xAAbAAADAQEBAQEAAAAAAAAAAAAEBQYDAgEHAP/EAEcQAAIBAgQEBAMGAwYEAwkBAAECAwQRABIhMQUTQVEiYXGBFDKRBiNCUnKhYrHBFTOCktHwJFNzskPh8RY0NVRjoqOzwgf/xAAZAQADAQEBAAAAAAAAAAAAAAABAgMEAAX/xAAmEQACAgICAQQCAwEAAAAAAAAAAQIRAyESMUETIlFhMoFCccEU/9oADAMBAAIRAxEAPwCDrUEdWRFK3xB5kpRTYgCR1uve2S52I31AJX2OtSefNO0EbuQWdozyptLXcbq38YHU9CcD/aWfkVPDOJrFGbtnSPMy3Fo5NSrBgc8j6gjTbC88VpKt3kqoDSSsxN6SMGP0EZYW9mt5dcBO1sh6bW4jWKham4okUjIy5GZxIyjwZdbvfKVINg17d8u2PPsf9nEfi0FTW1VFIkDcw0lPUJNLKR0Cgm47+WEdfxGJqQUlAJVhduZOzgIZWGwIBOg7X1Jv2wBDNJBIksDukqEMjobFSNbg9D5jAkpNPZXGuJ9H43HCDJyoaiPM7TSycqNUzk31d5Ao7WK9AQAQMSVRFlCvNQLMxvrHXoyyAbmyksT55jb2xS8N+0U3FuGPPOiPUUa5pRfxBOroD001HT8JF8pXcToo5lAhSKreUXj+J0lksLHJKtsxGxV/EO2IwuOmVYipuLUdO4ePg9OLfi58uf2ObT2F/PGv9t0nPMh4XER+QiIg/wD47/vj1aqRYjT09W0eQWNLXIpHoGIsfQhfLGfD5qatn5DcHjkZ7/8",
  ),
  Blog(
    uuid: uuid.generate(),
    title: "Test Blog 1!!!",
    createdDate: DateTime.now().subtract(const Duration(days: 4)),
    blogContent: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    // imageData: "SW1hZ2UoaW1hZ2U6IEFzc2V0SW1hZ2UoYnVuZGxlOiBudWxsLCBuYW1lOiAiYXNzZXRzL3BsYWNlaG9sZGVyLnBuZyIpLCBhbGlnbm1lbnQ6IEFsaWdubWVudC5jZW50ZXIp",
  ),

  //imageData: "/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMSEhUSEhISFRUXFxUVFRUVEhcVFRUQFRUWFxUVFRUYHSggGBolHRUVITEhJSkrLi4uFx8zODMtNygtLisBCgoKDg0OGxAQGi8lICUtLS0tLystLS0tLS0tLS0tLS0vLS8tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLf/AABEIAOEA4QMBIgACEQEDEQH/xAAbAAACAgMBAAAAAAAAAAAAAAAEBQMGAAECB//EAEQQAAEDAgQDBgMFBQYEBwAAAAEAAgMEEQUSITFBUWEGEyJxgZEyUrEUI0Kh0TNiweHwFUNTcoKSBxY08RckVGODk8L/xAAaAQACAwEBAAAAAAAAAAAAAAACAwABBAUG/8QAMhEAAgIBAwIEBAQGAwAAAAAAAAECEQMEITESQRMiUWEFMnGRgdHh8BQjUnKhsRUzQv/aAAwDAQACEQMRAD8AbRlEAoQKUP0XORiOnyqF0qincgZKpU0WCMdnqXn5Rb3TDMEhwqa7pHc3I506JqmXLkJlAKBlke0HI4i+miw1C0991dIKLrdCPuJYySxzgSbkgkG/NPOz1U6thlilY/I68TyBYOda4LSbgPAsduC01O+zDWxvuSS2TMe6t4M7ACHkjUOvppwurh09SbNKn17MrMUIwuYTQSSODXZKiOTLd0Q1do0DxsALvK/Dfp+L93XzvY8sjqGNkBa42J0IcLb7vcmX/EuN0bYsRp2BkT3Bkpy2cXxk93KWkcbvbfW4sCqlRdmXVHeR3DW07bud/wDIGhgB2N3HToVUsCTblu339v0L6aTs9HoMWMjGjMHZQW5gbkjXS/8AqPusxCGV/ijdYgAZQMpygcDf9FW6GnEAAYdtL7aDYWCaNxqwsWgrjzw54T647/UzpkD8Aqb/ALIm/JzSdfIpnhGAkOHfh4HysaXHzc5ujR63TfsfiPf5xma1zAPCSNWG/ibfa1vTTmmtHJHIHOhc12viLTfW3I7aeS1

 ];